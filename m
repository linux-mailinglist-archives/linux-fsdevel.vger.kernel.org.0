Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C834116B5B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 00:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgBXXe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 18:34:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXXe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PY3LO7INDVp+w+EyWwMiX5Boc/JVIKXMjl3FPvBvaMU=; b=V+DVcx87tJk52TKdGhJJCBe/uK
        inoCeiP5XzzrwO1gSANtRw13Log7drQQvTc2ys8TpcC5zg7m5wXudpHFc8Xdwq2LrHh+5UvyJWN09
        ZH51GF2VIzakAVkgfmaK81URA5C9MsOVW8QBhm0XybP/45eZ7IH8KwRWqcHWjww/5McIzpmIwqKb+
        twJjGwM9LaCEhOBtH7ryUU8OvzbcQx2CVJRWVA07HWcoGBjZJVFGKq1AHDJ110DowIiCl8GmXEV8q
        QicSV6dlsuvgePe6A5cVdTcwTit1pJP/gCadj4tyS84frv/bpUzN0EUL3u/g1orpMGqA1qqz4gauH
        mcy5oHXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6NFb-0000go-3n; Mon, 24 Feb 2020 23:34:59 +0000
Date:   Mon, 24 Feb 2020 15:34:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 2/9] block: Inline encryption support for blk-mq
Message-ID: <20200224233459.GA30288@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-3-satyat@google.com>
 <20200221172205.GB438@infradead.org>
 <20200222005233.GA209268@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222005233.GA209268@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 04:52:33PM -0800, Satya Tangirala wrote:
> > What is the rationale for this limitation?  Restricting unrelated
> > features from being used together is a pretty bad design pattern and
> > should be avoided where possible.  If it can't it needs to be documented
> > very clearly.
> > 
> My understanding of blk-integrity is that for writes, blk-integrity
> generates some integrity info for a bio and sends it along with the bio,
> and the device on the other end verifies that the data it received to
> write matches up with the integrity info provided with the bio, and
> saves the integrity info along with the data. As for reads, the device
> sends the data along with the saved integrity info and blk-integrity
> verifies that the data received matches up with the integrity info.

Yes, a device supporting inline encryption and integrity will have to
update the guard tag to match the encrypted data as well.  That alone
is a good enough reason to reject the combination for now until it
is fully supported.  It needs to be properly document, and I think
we should also do it at probe time if possible, not when submitting
I/O.
