Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B503059B2DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Aug 2022 10:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiHUIxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Aug 2022 04:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiHUIxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:53:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAB51C104;
        Sun, 21 Aug 2022 01:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZG4Es9fzRMT5wrH3Tq+h9KlclsxiCzHKQ6STwuA6oEY=; b=NPTUpR2TGbEGKev6MERMWxooFG
        ZiJJjPsPAHnqBUcO2CFAj6Vu6hAc3j5M6DeVz3k2hJd7xxalHutHctTFyvYAhRSiMuYQzdMYaAa9k
        WBNgoPSU6TF4upc7I+yWqXWo+afkfRMrrsiTEmeBXwGm9kKSvw1mY2HuqMGQj1ybZWFBcviB7t/Jx
        CNZtj16845VF1Evf0T8Auz57FsdmXm7IQcRaeQn96X3j+ZSDhD8Nyc4APtWOwsUqG0QARrCSLeVgb
        xIMkJ0036ubpmdQL4mSj6MNnxsleHp2IQ98hONYLivxszc2hcm0EoaksqSX32ZF8ehDAQbYS5mLFa
        jLqkzAsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oPgi5-008Q9X-HL; Sun, 21 Aug 2022 08:53:33 +0000
Date:   Sun, 21 Aug 2022 01:53:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v4 6/9] f2fs: don't allow DIO reads but not DIO writes
Message-ID: <YwHyjVwCGBqzzbd/@infradead.org>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-7-ebiggers@kernel.org>
 <YtyoF89iOg8gs7hj@google.com>
 <Yt7dCcG0ns85QqJe@sol.localdomain>
 <YuXyKh8Zvr56rR4R@google.com>
 <YvrrEcw4E+rpDLwM@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvrrEcw4E+rpDLwM@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 15, 2022 at 05:55:45PM -0700, Eric Biggers wrote:
> So if the zoned device feature becomes widely adopted, then STATX_DIOALIGN will
> be useless on all Android devices?  That sounds undesirable.  Are you sure that

We just need to fix f2fs to support direct I/O on zone devices.  There
is not good reason not to support it, in fact the way how zoned devices
requires appends with the Zone Append semantics makes direct I/O way
safer than how f2fs does direct I/O currently on non-zoned devices.

Until then just supporting direct I/O reads on zoned devices for f2fs
seems like a really bad choice given that it will lead to nasty cache
incoherency.
