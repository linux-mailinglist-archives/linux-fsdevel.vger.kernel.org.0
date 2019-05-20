Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35F36239F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 16:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390987AbfETO1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 10:27:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39610 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390076AbfETO1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 10:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HpHK7d9UhVQk6/UDLmcKvRAr3yC+xCmCY5CGJZTfZXc=; b=IE9rXBhT2+Fpt4GF81TIhGa6B
        0MoKbpt/Tjeg51MoV5X92xaKdt0bW0lt7c5X/6IPmOfPW5Dmvs6+cn0SaqWCFlEwFxydUxXiwGlmj
        LKwnQho5efQK+HlMK3H2tG9B5ZFk6qWK4XUHvo2X9ItQdfpNC/JeibKdeUEc4exAMtd0s9GggiXg/
        /n24bPO+ZxK+61XDPkHgUOs8GFk0d3SINW9VZL4aaAOUe5VRp2TorL6CkZucByg/Jgp7XgUAfO2cw
        Sn5FpgonxEAzLbW/umHa+jfOrVedJikTx9SPKX1sHHeg7vsgYwlEq0N1d8SQFFBT0j/yivx9dpwiG
        dwPcptiiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSjG3-0006Ti-Lt; Mon, 20 May 2019 14:27:19 +0000
Date:   Mon, 20 May 2019 07:27:19 -0700
From:   'Christoph Hellwig' <hch@infradead.org>
To:     kanchan <joshi.k@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, prakash.v@samsung.com,
        anshul@samsung.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
Message-ID: <20190520142719.GA15705@infradead.org>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <20190510170249.GA26907@infradead.org>
 <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 11:01:55AM +0530, kanchan wrote:
> Sorry but can you please elaborate the issue? I do not get what is being
> statically allocated which was globally available earlier.
> If you are referring to nvme driver,  available streams at subsystem level
> are being reflected for all namespaces. This is same as earlier. 
> There is no attempt to explicitly allocate (using dir-receive) or reserve
> streams for any namespace.  
> Streams will continue to get allocated/released implicitly as and when
> writes (with stream id) arrive.

We have made a concious decision that we do not want to expose streams
as an awkward not fish not flesh interface, but instead life time hints.

I see no reason to change from and burden the whole streams complexity
on other in-kernel callers.
