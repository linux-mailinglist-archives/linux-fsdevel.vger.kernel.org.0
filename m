Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD1B78E5AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 07:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbjHaFcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 01:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbjHaFcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:32:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531ADEA;
        Wed, 30 Aug 2023 22:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xLSjcWXbCmjXS8fd81zpTX2dPxnIZzfDeuK2kWRJmmI=; b=l0FUaTNO5IOCIhjJdMkcYuzDXv
        dT07I9pBgnFDb0MWVT1K0BZLw9ufXemWHzhH9KhOSwUbdrVDBPB/PsQshGoaB9E01VZTKGnZXG/6P
        n8Kl0Ht1n6fpYq5tEp6knTGAp4ak6lVPj0Tfo/TVlUPTw5jOS+Jy8b0QiWxhHB9RfCXi2Z5dfNkxF
        590US57RMsFgcFrZbV30ovokOckXBB9QzqZ5usK3bdYOjPJe8ALpA7F0lJ9IMAwVx9yb/DtQMZj6Q
        vZdXbN9vwWrWhR3Rs9iC5pqfUHjCSDMs4JXgNG0ti0boRE0rxRV50kuS2edGsAVOqrcYQ48CE4aLy
        gqlboXzg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qbaHh-00Egl5-0w;
        Thu, 31 Aug 2023 05:32:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: sb->s_fs_info freeing fixes
Date:   Thu, 31 Aug 2023 07:31:53 +0200
Message-Id: <20230831053157.256319-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sb->s_fs_info should only be freed after the superblock has been marked
inactive in generic_shutdown_super, which means either in ->put_super or
in ->kill_sb after generic_shutdown_super has returned.  Fix the
instances where that is not the case.

Diffstat
 arch/s390/hypfs/inode.c      |    3 +--
 fs/devpts/inode.c            |    2 +-
 fs/ramfs/inode.c             |    2 +-
 security/selinux/selinuxfs.c |    5 +----
 4 files changed, 4 insertions(+), 8 deletions(-)
