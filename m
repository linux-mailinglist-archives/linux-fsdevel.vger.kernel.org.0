Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CABF4E5EBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 07:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbiCXGfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 02:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiCXGfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:35:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E3A972D7;
        Wed, 23 Mar 2022 23:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QV0KhUQHKl4aXmBQYHNqlykHIpFUuOHUwDc5QgUPTYY=; b=yEk52TU+FpRR4o0qmJ21Ds/FEZ
        AZQs4fuEk/yEesqWBuwkid/mzwJEoyEnLvnkrS5O7t7vVch33QcJixa4IfyVPgpgIli/+pI1pBVhA
        eE+wS5VrBmv+t8ywPDmv4sSD40c8wOuT+eeysEG/DPDghdMgZwwT5szUb2xbtOHsMhLkA8s2KKY8W
        R/cQb9fH1FIqWa0KeLz9hoUKoVzd9yB3aXjV9u4ouSXURUe38J/fRHLUbmRgkFABxZKFEZGw4dhFs
        6E3rjY2JCkQaJ97/3pAx9ezs8YexGQC7uJuJfalkrRii/5LXSX33sxp2+tjjDSqW5G9Fyg/E94zyH
        szJFQHhw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXH2v-00Fqwq-E6; Thu, 24 Mar 2022 06:34:09 +0000
Date:   Wed, 23 Mar 2022 23:34:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <YjwQ4dLH7BWOqZqr@infradead.org>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
 <YjudB7XARLlRtBiR@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjudB7XARLlRtBiR@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 06:19:51PM -0400, Theodore Ts'o wrote:
> I'm still a bit puzzled about the reason for getvalues(2) beyond,
> "reduce the number of system calls".  Is this a performance argument?
> If so, have you benchmarked lsof using this new interface?

Yeah.  Even if open + read + close is a bnottle neck for fuse or
network file systems I think a io_uring op for just that is a much
better choice instead of this crazy multi-value operation.

And even on that I need to be sold first.
