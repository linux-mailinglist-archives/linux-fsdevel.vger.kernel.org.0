Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60C138E296
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 10:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhEXItU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 04:49:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:59822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232513AbhEXItQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 04:49:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621846066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=unOUl6gRgCjBYYNpjWpVJ3zrEt7xglAjgnort/xzqys=;
        b=LHSca4th1bpYxIlM22/rj/Urhw/gPPc5wQ37C9Yu7mkpnduT72aKFWg/R0b+m6sOx+uIFY
        YlRBPkwZj4Z8Pa0Nv+63c3SWyX9pW76E+md/A/7GFepRYyxSXfma/0eiKnhDMSjo1DMa+C
        EyVX53mxrStrqvUIYYn3F1Wu9y8IUFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621846066;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=unOUl6gRgCjBYYNpjWpVJ3zrEt7xglAjgnort/xzqys=;
        b=N3bJoSFJwoVhqoOM7Ti9YfX/N6Qa2+h17SkHRloW5bY461hRUtnObPpjSw1j+gSsj2eOKu
        S3dUdYRcPnqSu3Ag==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90402AB6D;
        Mon, 24 May 2021 08:47:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 59F3C1F2CA2; Mon, 24 May 2021 10:47:46 +0200 (CEST)
Date:   Mon, 24 May 2021 10:47:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>, amir73il@gmail.com,
        christian.brauner@ubuntu.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <20210524084746.GB32705@quack2.suse.cz>
References: <cover.1621473846.git.repnop@google.com>
 <20210520135527.GD18952@quack2.suse.cz>
 <YKeIR+LiSXqUHL8Q@google.com>
 <20210521104056.GG18952@quack2.suse.cz>
 <YKhDFCUWX7iU7AzM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKhDFCUWX7iU7AzM@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 22-05-21 09:32:36, Matthew Bobrowski wrote:
> On Fri, May 21, 2021 at 12:40:56PM +0200, Jan Kara wrote:
> > On Fri 21-05-21 20:15:35, Matthew Bobrowski wrote:
> > > On Thu, May 20, 2021 at 03:55:27PM +0200, Jan Kara wrote:
> > > There's one thing that I'd like to mention, and it's something in
> > > regards to the overall approach we've taken that I'm not particularly
> > > happy about and I'd like to hear all your thoughts. Basically, with
> > > this approach the pidfd creation is done only once an event has been
> > > queued and the notification worker wakes up and picks up the event
> > > from the queue processes it. There's a subtle latency introduced when
> > > taking such an approach which at times leads to pidfd creation
> > > failures. As in, by the time pidfd_create() is called the struct pid
> > > has already been reaped, which then results in FAN_NOPIDFD being
> > > returned in the pidfd info record.
> > > 
> > > Having said that, I'm wondering what the thoughts are on doing pidfd
> > > creation earlier on i.e. in the event allocation stages? This way, the
> > > struct pid is pinned earlier on and rather than FAN_NOPIDFD being
> > > returned in the pidfd info record because the struct pid has been
> > > already reaped, userspace application will atleast receive a valid
> > > pidfd which can be used to check whether the process still exists or
> > > not. I think it'll just set the expectation better from an API
> > > perspective.
> > 
> > Yes, there's this race. OTOH if FAN_NOPIDFD is returned, the listener can
> > be sure the original process doesn't exist anymore. So is it useful to
> > still receive pidfd of the dead process?
> 
> Well, you're absolutely right. However, FWIW I was approaching this
> from two different angles:
> 
> 1) I wanted to keep the pattern in which the listener checks for the
>    existence/recycling of the process consistent. As in, the listener
>    would receive the pidfd, then send the pidfd a signal via
>    pidfd_send_signal() and check for -ESRCH which clearly indicates
>    that the target process has terminated.
> 
> 2) I didn't want to mask failed pidfd creation because of early
>    process termination and other possible failures behind a single
>    FAN_NOPIDFD. IOW, if we take the -ESRCH approach above, the
>    listener can take clear corrective branches as what's to be done
>    next if a race is to have been detected, whereas simply returning
>    FAN_NOPIDFD at this stage can mean multiple things.
> 
> Now that I've written the above and keeping in mind that we'd like to
> refrain from doing anything in the event allocation stages, perhaps we
> could introduce a different error code for detecting early process
> termination while attempting to construct the info record. WDYT?

Sure, I wouldn't like to overengineer it but having one special fd value for
"process doesn't exist anymore" and another for general "creating pidfd
failed" looks OK to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
