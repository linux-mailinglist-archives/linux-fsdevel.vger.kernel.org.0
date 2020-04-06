Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2A19FAC0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgDFQqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 12:46:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbgDFQqn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n6KLsIL5V6k4cItTzey0/EFVgvxOMTcpSkXR1SJgtjQ=; b=M1pb1wWDO+F6JveWkE4TuyTu2l
        GM52up/Ub+9M/NBHzbc+N/vpI5faViAewjHfL7qtJUTtMF0vFo7S/joX28WPkZmb1MuLHvjvBNksI
        k+rtfcvPwYavL0WZ6P6dFcT9Z8xcJGstFeBCml5Og9cG7DB20An7kg16oWyVVw8GVXYr/y+E27Siq
        hBpJyJR1QuuJTh2xScMKWG7ryaoT/64HPVjtsdRvq2b7brJgl4+OWDKIiR28rI41v2KOAavLFu99g
        mgAal+yLlDYw+LDkMZp3ekPIHvr4p1hZlL/bl4u/oaOuoCykWDy+qEQGAP2JY7QvdJdILOVzgrvQd
        gcsQPHIg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLUtV-0002ZP-NF; Mon, 06 Apr 2020 16:46:41 +0000
Date:   Mon, 6 Apr 2020 09:46:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Sergey Alirzaev <l29ah@cock.li>
Subject: Re: [GIT PULL] 9p update for 5.7
Message-ID: <20200406164641.GF21484@bombadil.infradead.org>
References: <20200406110702.GA13469@nautica>
 <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406164057.GA18312@nautica>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 06, 2020 at 06:40:57PM +0200, Dominique Martinet wrote:
> Anyway, I agree looking at O_NONBLOCK for that isn't obvious.
> I agree with the usecase here and posix allows short reads regardless of
> the flag so the behaviour is legal either way ; the filesystem is
> allowed to return whenever it wants on a whim - let's just add some docs
> as you suggest unless Sergey has something to add.

Ahahahahhahahahahaha.

POSIX may well "allow" short reads, but userspace programmers basically
never check the return value from read().  Short reads aren't actually
allowed.  That's why signals are only allowed to interrupt syscalls if
they're fatal (and the application will never see the returned value
because it's already dead).
