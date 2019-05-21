Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C29324A59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 10:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEUI2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 04:28:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfEUI2t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 04:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dzgDZjQNK4+WfEDvGGwqugQnmKy730vEONl7eH1nok4=; b=HBJ7MsNn+aPvz98REpWd9DgMm
        dmnQ22k0MVUdI1ghk5enllEkjxUbxymVaLD7NVE6XpFXuVuv4deanC9rt+7COcMZ/bSTF3cHs6XrG
        EeZg8OP2FHkZjEbwkKC1aTNGB4Ls0/51AIQzi3f/1Uci5dQ16U1VCCzTGWzYbCKXJmEwGKkHgrvK5
        EoXiYMJYKCyp/V8tyOXRvKhNzvYGACLupH4EflRc6z6y3dqh4E2dd9Tw/PbH2SBxltIIjqpv96KkO
        f46PoXLEVplgIBXtbi95kuZgzMTGZdJsCqab99Yadc2yzaoJ544SH8krtRYiN4SSqSQlm+px8h5ZO
        VZdh3LauA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hT08c-0005iu-QJ; Tue, 21 May 2019 08:28:46 +0000
Date:   Tue, 21 May 2019 01:28:46 -0700
From:   'Christoph Hellwig' <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     'Christoph Hellwig' <hch@infradead.org>,
        kanchan <joshi.k@samsung.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        prakash.v@samsung.com, anshul@samsung.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
Message-ID: <20190521082846.GA11024@infradead.org>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <20190510170249.GA26907@infradead.org>
 <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
 <20190520142719.GA15705@infradead.org>
 <20190521082528.GA17709@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521082528.GA17709@quack2.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 21, 2019 at 10:25:28AM +0200, Jan Kara wrote:
> performance benefits for some drives. After all you can just think about it
> like RWH_WRITE_LIFE_JOURNAL type of hint available for the kernel...

Except that it actuallys adds a parallel insfrastructure.  A
RWH_WRITE_LIFE_JOURNAL would be much more palatable, but someone needs
to explain how that is:

 a) different from RWH_WRITE_LIFE_SHORT
 b) would not apply to a log/journal maintained in userspace that works
    exactly the same
