Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828D862D381
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 07:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbiKQGcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 01:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiKQGcG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 01:32:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5C3136A;
        Wed, 16 Nov 2022 22:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sPTNEKYS/tLrxLQ4oI8+Sww3RL9H9VBsThKBpc9p/Gk=; b=K5/Kn6cFMb9LpqpOmmVr3AL3ai
        0vZiISKwXqKUiJyr5NDOKZcFSpggWGsQkawGPm3P7UqdnGkVIGS0HN54pOlcTrJ8rePonZkJs3Cil
        8bG5OKkn5iawEo8woWwszoVV1jztfvn8yDDH4UUHHaZgV+LkaxPvvIKtxh7sEHllokJHoVwbKvpOR
        ENvaQDOMDREuKSfPLrgrnsEd9eK2C9hvWh0vih31N633ucRXxLWAkuGXNyd7W0qzrIZ0pV3+UyCxA
        ivXc9kNZLeJEgwy4smO9WMtwJHqptMT8zrurd6/ISPrEggAEdLgDwvS6/Hx+XBRJGJhsBKQH7y+wz
        1FJWbVoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovYR9-00Aqki-1y; Thu, 17 Nov 2022 06:31:47 +0000
Date:   Wed, 16 Nov 2022 22:31:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Dave Kleikamp <shaggy@kernel.org>,
        Bob Copeland <me@bobcopeland.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        linux-karma-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [PATCH 2/9] ext2: remove ->writepageo
Message-ID: <Y3XVU/gdoT5EH6xh@infradead.org>
References: <20221113162902.883850-1-hch@lst.de>
 <20221113162902.883850-3-hch@lst.de>
 <20221114104927.k5x4i4uanxskfs6m@quack3>
 <Y3UMV2mB5BkMM5PY@infradead.org>
 <20221116182040.tecis3dqejsdqnum@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116182040.tecis3dqejsdqnum@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 07:20:40PM +0100, Jan Kara wrote:
> Looking at the code, IMO the write_one_page() looks somewhat premature
> anyway in that place. AFAICS we could handle the writeout using
> filemap_write_and_wait() if we moved it to somewhat later moment. So
> something like attached patch (only basic testing only so far)?

Yes, this looks sensible.  Do you want to queue this one and the
ext2 and udf patches from this series if the testing works fine?

The same transformation should also be done for minix, sysfs and
ufs.  And a bunch of the others are probaby similar as well.
