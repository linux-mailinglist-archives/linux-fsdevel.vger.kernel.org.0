Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5197921BF84
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jul 2020 00:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgGJWE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 18:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGJWE7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:04:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A84C08C5DC;
        Fri, 10 Jul 2020 15:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sm08KILQrIhAFoGlCB+I5zhmi1eIMEDSey/M3AAwvrU=; b=Gf95zy8J04apBo9wUZ1mnOjWys
        Q3E03aUJHod0cOCoGZfdB++6r3mBBHEKatQ07qkf93nEwhMrFMsQ2Ca/R1uwDGBQtByztdqV22DbK
        MbowX9JA/4O7y2NTMT32X7ukvtTKvL4/tDSchahf7/ARoWtxtGK3tAyFycxBMjF07h2aGRzNfDyBF
        896zhV0TFTjt1H9YL00Om/6oR87oi92+QAYOnGSnDR68RuREB5bOdQ0YbsY7JcalooY6BII+0YORf
        A/9yXRmMifrzgpx+7GSxIYeCBTW8H9j9HVFaCoB1CvgXqNlUuS9P0V4JDL+gHl0AwbpanQyn4Gw33
        z3h2bHmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ju17r-0000Yi-Ej; Fri, 10 Jul 2020 22:04:11 +0000
Date:   Fri, 10 Jul 2020 23:04:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: Remove FIRMWARE_PREALLOC_BUFFER from
 kernel_read_file() enums
Message-ID: <20200710220411.GR12769@casper.infradead.org>
References: <20200707081926.3688096-1-keescook@chromium.org>
 <20200707081926.3688096-3-keescook@chromium.org>
 <3fdb3c53-7471-14d8-ce6a-251d8b660b8a@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fdb3c53-7471-14d8-ce6a-251d8b660b8a@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 10, 2020 at 02:00:32PM -0700, Scott Branden wrote:
> > @@ -950,8 +951,8 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
> >   		goto out;
> >   	}
> > -	if (id != READING_FIRMWARE_PREALLOC_BUFFER)
> > -		*buf = vmalloc(i_size);
> > +	if (!*buf)
> The assumption that *buf is always NULL when id !=
> READING_FIRMWARE_PREALLOC_BUFFER doesn't appear to be correct.
> I get unhandled page faults due to this change on boot.

Did it give you a stack backtrace?

