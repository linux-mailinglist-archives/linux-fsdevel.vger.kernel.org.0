Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0FC49496E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 09:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359205AbiATI2f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 03:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiATI2e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:28:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85834C061574;
        Thu, 20 Jan 2022 00:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/j3ZP5oOwU7RB5jo7ROztDrujmjBt8BH3fryKjW5QLk=; b=zVTuEpUT8AVEBvWepzTiACcSeE
        6SYmFVQ78Xb/5MjcwEglnGTgt5JQq3wg47vlzYW/O0tJcfuMXsfqrWAW0lNQoicKacUhHOv35qjZh
        S1s3wDJM3ghHTiOTbnqt0XJiijgtUU5S94zbes1s965OrRXCnBAyo6DWRCEBZZgntK7rusmo4Lv7l
        q0J9kX3RaffAFv3uH5WvmGHFc6iNuyFYufwrnWgFS5un3mhRp9SlqRcAvzl5+kASyO50V4RRlPBK8
        05INttOpWuKQW01uYZ6rc2kCMCBTZcXo8t5dPya6BgGQ2mYY5MyYrD8dPIUC2CzqwLTk229Plpj/Y
        xt5H2Heg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nASo6-009l59-0Q; Thu, 20 Jan 2022 08:28:34 +0000
Date:   Thu, 20 Jan 2022 00:28:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v10 2/5] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <YekdMU8W7jzwY/88@infradead.org>
References: <20220120071215.123274-1-ebiggers@kernel.org>
 <20220120071215.123274-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120071215.123274-3-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:12:12PM -0800, Eric Biggers wrote:
>  	bio = bio_alloc(GFP_KERNEL, 1);
> +	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> +				  GFP_KERNEL);

Note that this will create a (harmless) conflict with my
"improve the bio allocation interface" series.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
