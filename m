Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286C970618D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 09:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjEQHpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 03:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjEQHpS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 03:45:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC12118;
        Wed, 17 May 2023 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vium4kzZwZijke38DwhAMJr0846uD/O6movHx6mFnao=; b=pcNydiRAb2YicDVJWxYVscV2Vy
        12fpDoJ6FLMerw70YFritnAS3eCgLQ9zUTqx4VGqvAZhT4Do6xJSyRwcHqe4kDZM+ACpb1OxAgj5z
        BmTGnmBJBsoT79w5cHfSiAqWnAjuv/9HCrBFGT31kKL6AN+6JKaOP7F2yebsnwtlIgTyeOk2J0ZUX
        cXp1mOS29tvJRO/HH9xDaVP8M4PEHGS6scRDMofMTL9bEn+EvhDswi/o5eUR2ALg6GekkABkPGzFR
        9i7+Pmh+J7YRtBFWc6CNlqlDXQetHvoGevvuHEWo/Evb6PJ315FtBNXkJkFwebEPyQ/ORgnI/3Oqw
        fd+c34aA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzBqT-008iol-2G;
        Wed, 17 May 2023 07:45:13 +0000
Date:   Wed, 17 May 2023 00:45:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A pass-through support for NFSv4 style ACL
Message-ID: <ZGSGCTWOWkwIbvQE@infradead.org>
References: <20230516124655.82283-1-jlayton@kernel.org>
 <20230516-notorisch-geblickt-6b591fbd77c1@brauner>
 <TYXPR01MB18549D3A5B0BE777D7F6B284D9799@TYXPR01MB1854.jpnprd01.prod.outlook.com>
 <cc4317d9cb8f10aa0b3750bdb6db8b4e77ff26f8.camel@kernel.org>
 <20230517-herstellen-zitat-21eeccd36558@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517-herstellen-zitat-21eeccd36558@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 09:42:59AM +0200, Christian Brauner wrote:
> I have no idea about the original flame war that ended RichACLs in
> additition to having no clear clue what RichACLs are supposed to
> achieve. My current knowledge extends to "Christoph didn't like them".

Christoph certainly doesn't like Rich ACLs, as do many other people.

But the deal block was that the patchset:

 - totally duplicated the VFS level ACL handling instead of having
   a common object for Posix and the new ACLs
 - did add even more mess to the already horrible xattr interface
   instead of adding syscalls.
