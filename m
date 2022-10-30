Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AF6128F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Oct 2022 09:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJ3INZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Oct 2022 04:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3INY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Oct 2022 04:13:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25C718B;
        Sun, 30 Oct 2022 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qDxMZSkyyFWSUZLR/zgbATIw970wK8DPWliBx9KgMxU=; b=I3h1LwtQTwdn70nvX8XupBOqlo
        KZZqvJTNMJuUYLS/stq2eRAL45oqsgygNvWAFl6dp5ytI5pawaMmrXNWcg8gzgnF6HfKbKAxmrKI/
        cUo5UI43DFPCPWvXciTVXC7gM5xcpjWKlmKqEMDs3jaV9uGg7F2ZAo9GexG/79bAdWubiAHm3Wc0A
        uaVFC+7iphDXTdIyk2nQ0fgfMr+dCS8qdJFsNJHLoOk7crZaNgbyLoQ2reQ+iA/U2OjmiME8SG4Ii
        ZpaanpKLABFgOYIGnJxIRMG6nMJbx0X9CqHzvCdd1hxOA+gCV80iLHgnQZkWA9skhvcY7FfDLTc73
        feU2CDeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op3RB-00E4vm-0j; Sun, 30 Oct 2022 08:12:57 +0000
Date:   Sun, 30 Oct 2022 01:12:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] get rid of unlikely() on page_copy_sane() calls
Message-ID: <Y14yCDdhW/QGOp+l@infradead.org>
References: <Y1btOP0tyPtcYajo@ZenIV>
 <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This could explain why your are dropping the unlikely, 'cause just
from the page this is non-obvious.  Especially as the patch seems to
do a lot more than just removing an unlikely.
