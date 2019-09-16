Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1807B39D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 14:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbfIPMAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 08:00:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731582AbfIPMAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8H/tUs6jexV1FmhlZe3t10kL60wffM6RtCn29gBNiRM=; b=hA0FGePG9IUbxZYSxbb5hQV8f
        rqpJpElyjXJjIu6XUz4ev/W93AtWAbBFev95HuRcTu0e5tN2TnTmpnY/MZVr1oUPaPD4N2kJHNx7x
        yr8p7YTOOIgJSJP0XaixoVJTHqnDOvQT6cL1nRQ7lq6uGFtig1oCyAQz2OVUeIYg5jRcD0sxabKBo
        9iS1RUQwXxbodveiS4t/RITCaCdBiLQx+s5EcZBTLELktEQs8fqQLBsteKOpfz8gl84nNTZtVNxOY
        JA9h3qTpeH8wZWnNMY0k64Dc65o3PKkEkiwjTyNbGcI8SYfNdTI9ACglUDsCS7vg8M09uWS93skkR
        JcG2EOs+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9pgG-0002cK-48; Mon, 16 Sep 2019 12:00:32 +0000
Date:   Mon, 16 Sep 2019 05:00:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 1/6] ext4: introduce direct IO read path using iomap
 infrastructure
Message-ID: <20190916120032.GA4005@infradead.org>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <532d8deae8e522a27539470457eec6b1a5683127.1568282664.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <532d8deae8e522a27539470457eec6b1a5683127.1568282664.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 12, 2019 at 09:03:44PM +1000, Matthew Bobrowski wrote:
> +static bool ext4_dio_checks(struct inode *inode)
> +{
> +#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
> +	if (IS_ENCRYPTED(inode))
> +		return false;
> +#endif
> +	if (ext4_should_journal_data(inode))
> +		return false;
> +	if (ext4_has_inline_data(inode))
> +		return false;
> +	return true;

Shouldn't this function be called ext4_dio_supported or similar?

Also bonus points of adding a patch that defines a IS_ENCRYPTED stub
for !CONFIG_FS_ENCRYPTION to make this a little cleaner.

Also the iomap direct I/O code supports inline data, so the above
might not be required (at least with small updates elsewhere).
