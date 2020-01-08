Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CB213448C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 15:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgAHOF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 09:05:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56102 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgAHOF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y5Zp5DraPm2b4G9FdcZzJFZL/5Lu3ash5oRZzFlJrrQ=; b=ZeMiKnCPJGvzDo+O/UfvlAu/N
        sZUrBeXq9/DJgejEzJDxzf/u0MHMTCjzgqOmsbdOmsplpjSF+MkuW0DiAqEdNsTqfoUraHxNwAXbk
        i+aGIqK/w63kPTUn31L2QobgAZ2sdtvimXrYJLJ3R3ImQW6+o9UhbZ9Nz8dc9tG5TrZO/DXYVaW8/
        BDhX8Dsq/AtEbptlxAGgQ/JUdjA1Ym9PIeV+/4fkGukWoSaaYPAK+crtDFdUWjqOcbtQtFkZAQ4Ep
        oC76mAnRDykgejw3xuIYmk2Ev4MAzNf5BYpNLIfQTElSy/Orqb2coN+t9D2vtyZkweJH/95p4VxeN
        pMzqMtnIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipBy8-0008I6-HI; Wed, 08 Jan 2020 14:05:56 +0000
Date:   Wed, 8 Jan 2020 06:05:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 0/9] Inline Encryption Support
Message-ID: <20200108140556.GB2896@infradead.org>
References: <20191218145136.172774-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-1-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I haven't been able to deep dive into the details, but the structure
of this still makes me very unhappy.

Most of it is related to the software fallback again.  Please split the
fallback into a separate file, and also into a separate data structure.
There is abslutely no need to have the overhead of the software only
fields for the hardware case.

On the counter side I think all the core block layer code added should
go into a single file instead of split into three with some odd
layering.

Also what I don't understand is why this managed key-slots on a per-bio
basis.  Wou;dn't it make a whole lot more sense to manage them on a
struct request basis once most of the merging has been performed?
