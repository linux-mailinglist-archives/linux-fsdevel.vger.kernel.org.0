Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B64A6DBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 18:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfICQOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 12:14:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfICQOr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xj4IHJqHeJYYEcSgLS8shkVMaZQkrGWsskT7oJMqUYw=; b=braltILKIgR7j+bolyl/Am74e
        GA5G1h6/SRog8go9YljYnQJGGe7DA41jxF8zDlYAafT7IVyCksFyLhNL9F35EuoE8UcfOVS+UfYG+
        JcKM8aUTBsgQhUlvE511gF9YEz21J0bJkG3ccXze7VFIuGRwQCRG4TlzeOqJAw8NjXKOIoCT6fO9q
        TBr8ur0ndaELuFGhQ/+dQpAOQ7y85///3bVUHWQQRncGd+fvM+8uHTep2v26SAm+8TR31Ach0eI+r
        89PUlHQevRg1roi5EudlaZkn+K9IDuf34Vgk2XGwE34o9gLggDB/mcmFOufQo/T9EyRzeXRp5JxBg
        v+LNBrjTQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5BSA-0004kf-5q; Tue, 03 Sep 2019 16:14:46 +0000
Date:   Tue, 3 Sep 2019 09:14:46 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 2/2] iomap: move the iomap_dio_rw ->end_io callback into
 a structure
Message-ID: <20190903161446.GH29434@bombadil.infradead.org>
References: <20190903130327.6023-1-hch@lst.de>
 <20190903130327.6023-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903130327.6023-3-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 03:03:27PM +0200, Christoph Hellwig wrote:
> Add a new iomap_dio_ops structure that for now just contains the end_io
> handler.  This avoid storing the function pointer in a mutable structure,
> which is a possible exploit vector for kernel code execution, and prepares
> for adding a submit_io handler that btrfs needs.

Is it really a security win?  If I can overwrite dio->end_io, I can as
well overwrite dio->dops.

The patch itself looks sane, but I'm not sure about this particular reason.
