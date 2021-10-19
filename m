Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5B432E1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 08:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhJSG0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 02:26:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50458 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbhJSG0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:26:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 346CE2197E;
        Tue, 19 Oct 2021 06:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634624633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aNvJPt85vZf9bBMJjbgwMuKxAMmcbsHIJPwZz/3xngo=;
        b=aPPUZQip1FXzonJxM4wqd/690HrZk6fz9rhHm/1JCFBw9ALlZDpceFtf6flMY3j6oMRMFe
        AQmevTkq51HUk5WPl3N4P1eN9xv890mbZxJ7GfHV8xreOSPvAbt4ZkskV7eS7JuJeAvANa
        9uoyyw60aVq6hbOMcli3eofF+oZayMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634624633;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aNvJPt85vZf9bBMJjbgwMuKxAMmcbsHIJPwZz/3xngo=;
        b=GijXbiZXw/n+u9uG38fm5BwLSEeX5PBkSlrFwGvVSFdmfffvdMVEtRW9XLwkcJp1P8EfmE
        6ukLpP3n3DF7j3Dw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0341FA3B8A;
        Tue, 19 Oct 2021 06:23:52 +0000 (UTC)
Date:   Tue, 19 Oct 2021 08:23:51 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
In-Reply-To: <YW4uwep3BCe9Vxq8@T590>
Message-ID: <alpine.LSU.2.21.2110190820590.15009@pobox.suse.cz>
References: <20210927163805.808907-12-mcgrof@kernel.org> <YWeOJP2UJWYF94fu@T590> <YWeR4moCRh+ZHOmH@T590> <YWiSAN6xfYcUDJCb@bombadil.infradead.org> <YWjCpLUNPF3s4P2U@T590> <YWjJ0O7K+31Iz3ox@bombadil.infradead.org> <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org> <YWq3Z++uoJ/kcp+3@T590> <YW3LuzaPhW96jSBK@bombadil.infradead.org> <YW4uwep3BCe9Vxq8@T590>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > By you only addressing the deadlock as a requirement on approach a) you are
> > forgetting that there *may* already be present drivers which *do* implement
> > such patterns in the kernel. I worked on addressing the deadlock because
> > I was informed livepatching *did* have that issue as well and so very
> > likely a generic solution to the deadlock could be beneficial to other
> > random drivers.
> 
> In-tree zram doesn't have such deadlock, if livepatching has such AA deadlock,
> just fixed it, and seems it has been fixed by 3ec24776bfd0.

I would not call it a fix. It is a kind of ugly workaround because the 
generic infrastructure lacked (lacks) the proper support in my opinion. 
Luis is trying to fix that.

Just my two cents.

Miroslav
