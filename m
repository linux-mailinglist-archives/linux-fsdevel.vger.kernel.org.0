Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4E8E7025
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 12:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfJ1LKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 07:10:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1LKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QYRGqons38NtMgtcv+gzyzZCBRvkASR8tK2x6q26fog=; b=C2Fk946fmaN4QY8nAYZ1vMm2I
        w0+gKnBQrGuUVKOFpgp4SK2A5VKbLkM3ClkVdoLUznnQA0dzuDaj9icom7IfIUBW5ujgQZT8xqSLo
        vTiFTK5CZQgI9b6lcrtDBgnJCyRuF1avCfiAf7IMcXr6Nij4E/32a21gqi2o+SxkN5tyrkKCSvtDI
        4/yE9UG0hGsfX10WoOekfQ8N51JSZQCd3jSPmalVxKYLP/pDxAF2nXeyYsym4IWAFw5xLjDFku72w
        JXA17Jerqj3nWG+uUa94+7F4+cjrT8ekYPyfJuvu5lyg64HUkwPTXK3VjPlqgcZ5C3Ned657hv4il
        uw7PAqTww==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP2uw-0007FD-Nb; Mon, 28 Oct 2019 11:10:34 +0000
Date:   Mon, 28 Oct 2019 04:10:34 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH RFC] fs/fcntl: add fcntl F_GET_RSS
Message-ID: <20191028111034.GS2963@bombadil.infradead.org>
References: <157225848971.557.16257813537984792761.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157225848971.557.16257813537984792761.stgit@buzz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 01:28:09PM +0300, Konstantin Khlebnikov wrote:
> +	if (dax_mapping(mapping))
> +		pages = READ_ONCE(mapping->nrexceptional);
> +	else
> +		pages = READ_ONCE(mapping->nrpages);

I'm not sure this is the right calculation for DAX files.  We haven't
allocated any memory for DAX; we're just accessing storage directly.
The entries in the page caache are just translation from file offset to
physical address.

