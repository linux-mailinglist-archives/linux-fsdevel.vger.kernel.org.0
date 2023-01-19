Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C51F6731A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 07:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjASGOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 01:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjASGN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:13:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6287A66CDA;
        Wed, 18 Jan 2023 22:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xdy392OgNUxqb5TQg+GwRmeIQ1dBw7Q064Z/xIIHoEQ=; b=4KYOTnXgxy+iDt6rI0dK9ZOezo
        dj4jDRdPFcqgoHwptzOburbslhnRCZ4caKXUIIkjb+4f534D9uANxdh6JP7vRvq9SH38L07fcU1xa
        5NBbmW2fGaYYBzMxusRQ21jveHSBUmNTQRKAgGO32JNEJxCIf7q15QWDu1Bjal13VGzWvCPC8/1ZR
        xXSX7VhSq8t2Mrup/IlWlhtcqW0eHmqUgnVe6Pr4ye/mSrGCXKBf9CYtaCIG46YxQjGYTODlseoRI
        yPpAYH3zbJ7tihgPhWVqFxrANrLoDJ5LmFL5CEDqGIYu/s49qCV43TErawg/y/ci+CUIHMJEuA1MI
        xw+FGtpg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIOAs-003imG-Et; Thu, 19 Jan 2023 06:13:22 +0000
Date:   Wed, 18 Jan 2023 22:13:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: btrfs mount failure with context option and latest mount command
Message-ID: <Y8jfgsNbcKTLdnmQ@infradead.org>
References: <20230116101556.neld5ddm6brssy4n@shindev>
 <20230117164234.znsa4oeoovcdpntu@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117164234.znsa4oeoovcdpntu@ws.net.home>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 17, 2023 at 05:42:34PM +0100, Karel Zak wrote:
> It's a serious issue if btrfs is not ready for the new kernel fsconfig
> interface. I guess libmount cannot do anything else in this case
> (well, we can switch back to classic mount(2), but it sounds as a
> wrong solution).

Unfortunately a lot of file systems haven't been converted to the
fsconfig code yet, it's another case of adding new infrastructure to
the kernel then not following up on the conversion, and all too common
patter unfortunately :(  btrfs might be the only major disk file system,
but there's lot of others.
