Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 125F425777
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 20:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfEUST6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 14:19:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45230 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbfEUST5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 14:19:57 -0400
Received: by mail-qt1-f195.google.com with SMTP id t1so21608693qtc.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2019 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L4tC0jELcf8YEx069L5KgHyV51lzWFzvRfaNX5ISk+4=;
        b=hFu6RUdVqnw5buZBDvetwN24AhoYHJdyJYuJQmiFTnhdXsdmT1FI7YFc6Q/MvLL/tr
         mC4dQiwQp6AN8KTg4BdgTwvhTkhllToa62yL2aUQs2GJ0Gzei3FRn4phhtcdebsLxzbp
         TsUFDvzOSEGAuMqqOGNHjo1akyrfd07j8uJSoO1u/v2QePRcy52lZVN5BdxFiLWef5hV
         MNJJcE6SY/B6RCMocIEHo3ZnfNpMVdFTVy0IXyeuTRAhYuULeMkg3LEG5wSOwl7gNZWj
         cAQ/rbSNix+kujrDm2S15KFkniqLTb7AWtT2f3Ya4Zv43YpB9y6UuLCifBvvDEN8tdvc
         ZiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L4tC0jELcf8YEx069L5KgHyV51lzWFzvRfaNX5ISk+4=;
        b=Gebkui89udcGzAmbLHifCNbj8C8w96W8iUr+KPEyY+r3iosFj4MES1EQYihW+hAUqE
         ixFjSS56oJOaTQaDkCinRAIqsmfiO3nCTkkZO5LuFVjnEQsczWrDBNRUI4R+RixAZ0mi
         RixLYdbQ0nQoxr8HjYipf+kxOd5fgSWH41JfCW/8oIJiJyZVftkyaDAe3x9bTe5bbgIX
         /uEN84Z69sGJxJ6IA+Phn9xQ5IujKGsxBx3KISkITZtHfJYN3VBW2J4Ite0vx4WTIyfy
         ebD+Y3SCbTAzqyOkVwyLkNQs4wFmb2aNsEVgyzD6PEPfBAo7mosK+8bB1nn7CNTnq4r0
         rxlw==
X-Gm-Message-State: APjAAAX5RkHCX7Zkdospi/udV07a2i+rTNrKPm18GfRNEkx/n1bSXf47
        U9t0K/FgtlnqpJaepQoGlWvE8Q==
X-Google-Smtp-Source: APXvYqzqnNC3r0IufslOaWTqAuMUGIxBl1FW84w5B79zfVMLqcu2JkCCb9GiYVwl2sCQ/VgdhRQmvA==
X-Received: by 2002:ac8:1205:: with SMTP id x5mr54003801qti.284.1558462796368;
        Tue, 21 May 2019 11:19:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::744])
        by smtp.gmail.com with ESMTPSA id c9sm13855830qtc.39.2019.05.21.11.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 11:19:55 -0700 (PDT)
Date:   Tue, 21 May 2019 14:19:53 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, jmoyer@redhat.com,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Message-ID: <20190521181952.4vpruone2mzbczpw@MacBook-Pro-91.local>
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <20190518192847.GB14277@mit.edu>
 <20190520091558.GC2172@quack2.suse.cz>
 <20190521164814.GC2591@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521164814.GC2591@mit.edu>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 12:48:14PM -0400, Theodore Ts'o wrote:
> On Mon, May 20, 2019 at 11:15:58AM +0200, Jan Kara wrote:
> > But this makes priority-inversion problems with ext4 journal worse, doesn't
> > it? If we submit journal commit in blkio cgroup of some random process, it
> > may get throttled which then effectively blocks the whole filesystem. Or do
> > you want to implement a more complex back-pressure mechanism where you'd
> > just account to different blkio cgroup during journal commit and then
> > throttle as different point where you are not blocking other tasks from
> > progress?
> 
> Good point, yes, it can.  It depends in what cgroup the file system is
> mounted (and hence what cgroup the jbd2 kernel thread is on).  If it
> was mounted in the root cgroup, then jbd2 thread is going to be
> completely unthrottled (except for the data=ordered writebacks, which
> will be charged to the cgroup which write those pages) so the only
> thing which is nuking us will be the slice_idle timeout --- both for
> the writebacks (which could get charged to N different cgroups, with
> disastrous effects --- and this is going to be true for any file
> system on a syncfs(2) call as well) and switching between the jbd2
> thread's cgroup and the writeback cgroup.
> 
> One thing the I/O scheduler could do is use the synchronous flag as a
> hint that it should ix-nay on the idle-way.  Or maybe we need to have
> a different way to signal this to the jbd2 thread, since I do
> recognize that this issue is ext4-specific, *because* we do the
> transaction handling in a separate thread, and because of the
> data=ordered scheme, both of which are unique to ext4.  So exempting
> synchronous writes from cgroup control doesn't make sense for other
> file systems.
> 
> So maybe a special flag meaning "entangled writes", where the
> sched_idle hacks should get suppressed for the data=ordered
> writebacks, but we still charge the block I/O to the relevant CSS's?
> 
> I could also imagine if there was some way that file system could
> track whether all of the file system modifications were charged to a
> single cgroup, we could in that case charge it to that cgroup?
> 
> > Yeah. At least in some cases, we know there won't be any more IO from a
> > particular cgroup in the near future (e.g. transaction commit completing,
> > or when the layers above IO scheduler already know which IO they are going
> > to submit next) and in that case idling is just a waste of time. But so far
> > I haven't decided how should look a reasonably clean interface for this
> > that isn't specific to a particular IO scheduler implementation.
> 
> The best I've come up with is some way of signalling that all of the
> writes coming from the jbd2 commit are entangled, probably via a bio
> flag.
> 
> If we don't have cgroup support, the other thing we could do is assume
> that the jbd2 thread should always be in the root (unconstrained)
> cgroup, and then force all writes, include data=ordered writebacks, to
> be in the jbd2's cgroup.  But that would make the block cgroup
> controls trivially bypassable by an application, which could just be
> fsync-happy and exempt all of its buffered I/O writes from cgroup
> control.  So that's probably not a great way to go --- but it would at
> least fix this particular performance issue.  :-/
> 

Chris is adding a REQ_ROOT (or something) flag that means don't throttle me now,
but the the blkcg attached to the bio is the one that is responsible for this
IO.  Then for io.latency we'll let the io go through unmolested but it gets
counted to the right cgroup, and if then we're exceeding latency guarantees we
have the ability to schedule throttling for that cgroup in a safer place.  This
would eliminate the data=ordered issue for ext4, you guys keep doing what you
are doing and we'll handle throttling elsewhere, just so long as the bio's are
tagged with the correct source then all is well.  Thanks,

Josef
