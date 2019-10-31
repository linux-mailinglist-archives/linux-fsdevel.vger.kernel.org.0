Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40C6EB8E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 22:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfJaVWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 17:22:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfJaVWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 17:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vp+FXiDesIme9wZKEonBbY9EF/rmcc94oNJSVeB9Mnc=; b=X2NyMyJFykqbqzPbcpTyDRKbd
        BQ/j4YYDfZ+K17wIdlSnJWeMlmiwSCq9IMkXKUsUWN8Djbc19Zfhk+hIp7ZaVzlxBuLOGvbM7mtvD
        tdEuc2FEBLmOuRWXJW6ZqH7y/c0RNVVyx1fdanwkc0bf32knjKWhBgJhMskumnn4+48nVaeGOTn5Z
        Dz/c9saizy3IesFxr79it6vaiPCO38unEJK2Q48dPTaXVBxYTsN1JT29cogNarc3E4PHjH+0XHVS8
        wWix7xAS4JPhoqwv52QEQeoJ7XXluWPUny9K66o/qzd3n+iMFMDrWD33Gb0XpdR2PIr58Dp8mqtSI
        X2izGODzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQHtq-0008OR-Uf; Thu, 31 Oct 2019 21:22:34 +0000
Date:   Thu, 31 Oct 2019 14:22:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v5 3/9] block: blk-crypto for Inline Encryption
Message-ID: <20191031212234.GA32262@infradead.org>
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-4-satyat@google.com>
 <20191031175713.GA23601@infradead.org>
 <20191031205045.GG16197@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031205045.GG16197@mit.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 04:50:45PM -0400, Theodore Y. Ts'o wrote:
> One of the reasons I really want this is so I (as an upstream
> maintainer of ext4 and fscrypt) can test the new code paths using
> xfstests on GCE, without needing special pre-release hardware that has
> the ICE support.
> 
> Yeah, I could probably get one of those dev boards internally at
> Google, but they're a pain in the tuckus to use, and I'd much rather
> be able to have my normal test infrastructure using gce-xfstests and
> kvm-xfstests be able to test inline-crypto.  So in terms of CI
> testing, having the blk-crypto is really going to be helpful.

Implementing the support in qemu or a special device mapper mode
seems like a much better idea for that use case over carrying the
code in the block layer and severely bloating the per-I/O data
structure.
