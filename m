Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F8D78F8B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 08:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbjIAGsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 02:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjIAGsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:48:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C8E7E;
        Thu, 31 Aug 2023 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wIU8yR9yVBJtBb6ap2NIC84YFSXIDTo9rl29CNhKMOE=; b=C+j4ZyYIKLDX0xL/9yXUpTuB5R
        10vCCwGa0quV0LFVKd159sPjRPXJ7RXNHJlVdWtFO1JHs4fHGKs9gO2/h2b89j+433wDNR1WP9trh
        2mOe5AYdoepAZzlyk6OrQ0p+M+O57rvalV0uJQ06kh0UBNJXRogy9bvTNLjz6AMOubeXuGqykWHjV
        bf1S5UzsMgNNvROU1yWGoh33gSeCXht+gTfGpixaKEXhCbyKKItL/PrAIMxUVVczvO0kWo9UQYZ5C
        EcTEz/5PnqhFUxnhC5Ncqi2Z4jpX5/3gYrJWFcLTmkekhvqVzEieQ5mJWYDyFol69vhzEbS3Fz7Wf
        FOZtWqxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qbxxa-00GZ4i-2I;
        Fri, 01 Sep 2023 06:48:50 +0000
Date:   Thu, 31 Aug 2023 23:48:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/2] fs: Add and export file_needs_remove_privs
Message-ID: <ZPGJUtkAO1C+d8+y@infradead.org>
References: <20230830181519.2964941-1-bschubert@ddn.com>
 <20230830181519.2964941-2-bschubert@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830181519.2964941-2-bschubert@ddn.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 30, 2023 at 08:15:18PM +0200, Bernd Schubert wrote:
> File systems want to hold a shared lock for DIO writes,
> but may need to drop file priveliges - that a requires an
> exclusive lock. The new export function file_needs_remove_privs()
> is added in order to first check if that is needed.

As said last time - the existing file systems with shared locking for
direct I/O just do the much more pessimistic IS_SEC check here.  I'd
suggest to just do that for btrfs first step.  If we then have numbers
justifying the finer grained check we should update veryone and not
just do it for one place.

