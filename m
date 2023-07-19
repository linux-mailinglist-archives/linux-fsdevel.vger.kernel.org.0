Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFEA758DCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 08:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGSGcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 02:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGSGcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:32:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25E21FC0;
        Tue, 18 Jul 2023 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/s5SuSKavCuuj/hFLYyUYTA+bQWVcN4rBZzXOlC/BsY=; b=B9zLOcQ77ltk5BkG8IALoPk+Qx
        vj5vt1RKtG5xpVPwMQ95yhOhYZd2zL7RYeiYA0IGQor7qfRT1pPnyygRt7M5pAN7cOyvrReHRQNJu
        avQEH2nW1S4YbzVykq85YkFDd3ICa9tbnuVQJ6BmK7Gh+K4DZD+Plmt5ZTu//Y6R90LASXJIkN94e
        47WTiz2VRjG7IyogiFE95u2urB6pzE8wSTfcOrZf4w77XvuqP9kvE4Qb1A6IEUVwphl1F+5Syu3yV
        MRl3WE0WHnAU7aKn6T6Buec32LrlzVUYRR7c6qn2hfSteyhhXmcCfHa/rbkRCLVO4MAwaSOyBJnk/
        S/NJcm+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qM0iz-005lTJ-33;
        Wed, 19 Jul 2023 06:31:49 +0000
Date:   Tue, 18 Jul 2023 23:31:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bill O'Donnell <billodo@redhat.com>,
        Rob Barnes <robbarnes@google.com>, bleung@chromium.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: export emergency_sync
Message-ID: <ZLeDVcQrFft8FYle@infradead.org>
References: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
 <ZLcOcr6N+Ty59rBD@redhat.com>
 <ad539fad-999b-46cd-9372-a196469b4631@roeck-us.net>
 <20230719-zwinkert-raddampfer-6f11fdc0cf8f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719-zwinkert-raddampfer-6f11fdc0cf8f@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 19, 2023 at 07:53:32AM +0200, Christian Brauner wrote:
> On vacation until next. Please add a proper rationale why and who this
> export is needed by in the commit message. As right now it looks like
> someone thought it would be good to have which is not enough for
> something to become an export.

emergency_sync is a relaly bad idea and has all kinds of issues.
It should go away and not grow more users outside of core code,
and the one Guenther points to should never have been added.

If we want to allow emergency shutdowns it needs a proper interface
and not a remount read-only ignoring some rules that tends to make
things worse and instad of better, and even for that I'm not sure
I want modules to be able to drive it.
