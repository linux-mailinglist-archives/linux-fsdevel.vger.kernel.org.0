Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D8232C44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 09:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgG3HKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 03:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgG3HKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:10:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BECC061794;
        Thu, 30 Jul 2020 00:10:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596093010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+w/sK1SsZKUn1Dn3lJ80Y6FqshMKdUhZKeHK5jUWI9U=;
        b=ualbdPWSrWD9PSFYMBEowro0ByFP1H1D4BeTAwCZW4ISWnwsM5iMmiNENi5qqV4RjOyw/x
        R1oSCVNNteKIA5s1lUB6/vMdWwAkQ8ZAgavxGnttNkEkVQZ8vzdPCRQDFw0uG0ONKiZlGS
        T2rkCJcl+kcF9dsal0D6S9BuNjC7Yyd6EKfovGsM5vN8uqWQSEkLSmDkElzI4eCmzcW8TK
        BsHWMgLtB/HX1A4e7Ny72q/tomkBWw3SdExv+1Rdg7B779+JlgSgAu4u0rF7y9qddw00IJ
        V25WpzpgjaDxONHNpVkEuN9o1Segs20XrxpK6j4H31qpW7eWtITiyzhxo1yiRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596093010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+w/sK1SsZKUn1Dn3lJ80Y6FqshMKdUhZKeHK5jUWI9U=;
        b=pzTikaBTF7mRs6nV0Yky0Nu4FOX/qXu1LiyRtHFUpxCVd5vZMZPgxyN+t23SxBmvm3qe+A
        Bozdd5Yp3DDSWBCA==
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/23] seq_file: switch over direct seq_read method calls to seq_read_iter
In-Reply-To: <20200729205919.GB1236929@ZenIV.linux.org.uk>
References: <20200707174801.4162712-1-hch@lst.de> <20200707174801.4162712-16-hch@lst.de> <87eep9rgqu.fsf@nanos.tec.linutronix.de> <20200729205919.GB1236929@ZenIV.linux.org.uk>
Date:   Thu, 30 Jul 2020 09:10:10 +0200
Message-ID: <87eeota371.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:
> On Fri, Jul 17, 2020 at 11:09:13PM +0200, Thomas Gleixner wrote:
>> 
>> Needs some thought and maybe some cocci help from Julia, but that's way
>> better than this brute force sed thing which results in malformed crap
>> like this:
>> 
>> static const struct file_operations debug_stats_fops = {
>> 	.open		= debug_stats_open,
>> 	.read_iter		= seq_read_iter,
>> 	.llseek		= seq_lseek,
>> 	.release	= single_release,
>> };
>> 
>> and proliferates the copy and paste voodoo programming.
>
> Better copy and paste than templates, IMO; at least the former is
> greppable; fucking DEFINE_..._ATRIBUTE is *NOT*, especially due
> to the use of ##.

Copy and paste itself is not the issue, but once the copy and paste orgy
starts you end up with more subtle bugs and silly differences than
copies. I spent enough time cleaning such crap up just to figure out
that once you've finished a full tree sweep you can start over.

grep for these things is a nuisance, but it's not rocket science to
figure it out. I rather have to figure that out than staring at a
gazillion of broken implementations.

Thanks,

        tglx
