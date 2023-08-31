Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F8278E68C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 08:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245148AbjHaGbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 02:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjHaGbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:31:20 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F32A4;
        Wed, 30 Aug 2023 23:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x7jecP7KFnSNkO2DSlLMkbDbDAg7iq2vacoSweuUVPc=; b=cVawuss1wNIoGZOcmN5C7meYKF
        Vy/kJWEd5OD5HtcqD5T2XqYl4Fu7WSBl/JvhwO6onCzavlF4hgvO+lJ/RBKNOA04cP/J6c3GXp/qv
        MWarK/P/RwpPZkPbV8mufXhmeVUEb45//PNdFCnFMB81GGV+YFf7JwBeo7lZf9+wPjcnNxjgJ68b+
        NyjAoZsBRBNcegK/KVhNZhvhwMMyZ6nYXbApok/wChR5rIktiYBlA/FwMHdhtQqj74X0fpCy2+m/L
        7Vic6kGymDoa8x2qdIArpOB782pBILazZq0wRwby7lrPMhIUsmvS9HFfU/vvU/S1nQGRhDB1RqIHs
        77n9Vp2A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qbbCu-002GyT-2b;
        Thu, 31 Aug 2023 06:31:08 +0000
Date:   Thu, 31 Aug 2023 07:31:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 2/4] devpts: free sb->s_fs_info after shutting down the
 super block
Message-ID: <20230831063108.GE3390869@ZenIV>
References: <20230831053157.256319-1-hch@lst.de>
 <20230831053157.256319-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831053157.256319-3-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 07:31:55AM +0200, Christoph Hellwig wrote:
> sb->s_fs_info can only be safely freed after generic_shutdown_super was
> called and all access to the super_block has stopped.

Similar to ramfs case; nothing in dentry/inode eviction codepaths is
using anything in ->s_fs_info.  And references in tty are holding
an active ref to superblock in question, preventing ->kill_sb(), so
nothing from the outside is going to play with e.g. devpts_{new,kill}_index()
under us.
