Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5315419773
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 17:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhI0PO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhI0PO3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:14:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E67C061575;
        Mon, 27 Sep 2021 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8XzwjHs843zXfH+an8ktBMeno92g9Ry3oPa0mEU0F9Y=; b=yl6jRQe2sVgWrVgWeBgFJ+S7oR
        /e90qkak+HPKGyulGJm90XMNsFK/zfGqhgLeooNqscTavy6evL0HHFNge1Zzq2VrXwArcH6vbiw4z
        3Q6j+sxPlW8GcIiHNRkx4xwKkp+wy696/EKhiGyZais1OM6i0hJjjx9qbfYBhuUQt4SKr6zuTQu45
        F/FuoRActMgjTHcotZ+9bHWMAaDx37a7TEZpkeobrqw45MbXni9GhYrCB553/ALZwxOFsVSQJeeQR
        bOJ86jrRrPfXU12tbNZQCps3ePRpwisKB7zfcqv5hmEWBJn93+QesNl3X42AveF9ZHUVHrpIrmKmh
        cZHPP/IQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUsID-00344C-ET; Mon, 27 Sep 2021 15:11:45 +0000
Date:   Mon, 27 Sep 2021 08:11:45 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        rdunlap@infradead.org, rafael@kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, yzaikin@google.com, nathan@kernel.org,
        ojeda@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        vitor@massaru.org, elver@google.com, jarkko@kernel.org,
        glider@google.com, rf@opensource.cirrus.com,
        stephen@networkplumber.org, David.Laight@aculab.com,
        bvanassche@acm.org, jolsa@kernel.org,
        andriy.shevchenko@linux.intel.com, trishalfonso@google.com,
        andreyknvl@gmail.com, jikos@kernel.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, daniel.vetter@ffwll.ch, bhelgaas@google.com,
        kw@linux.com, dan.j.williams@intel.com, senozhatsky@chromium.org,
        hch@lst.de, joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH v7 00/12 (RESEND)] syfs: generic deadlock fix with module
 removal
Message-ID: <YVHfMVmy8Lo0J3vR@bombadil.infradead.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
 <YUjLAbnEB5qPfnL8@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUjLAbnEB5qPfnL8@slm.duckdns.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 07:55:13AM -1000, Tejun Heo wrote:
> On Fri, Sep 17, 2021 at 10:04:18PM -0700, Luis Chamberlain wrote:
> > In this v7 I've decided it is best to merge all the effort together into
> > one patch set because communication was being lost when I split the
> > patches up. This was not helping in any way to either fix the zram
> > issues or come to consensus on a generic solution. The patches are also
> > merged now because they are all related now.
> 
> Building up all the testing framewoork is really great. I have no opinions
> about the license related stuff but all other changes generally look good to
> me.

OK I am going to send a v8 shortly with the changes from folks addressed.
I'm going to trim the Cc list considerbly for that v8 as the list is already
quite large and I think it may appear as spam to some lists, I'll drop the
copyleft-next folks as hopefully the license stuff is out of the way.

  Luis

