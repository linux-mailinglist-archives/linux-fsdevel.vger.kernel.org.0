Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0304D348B6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 09:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhCYIWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 04:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhCYIWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:22:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4BAC06174A;
        Thu, 25 Mar 2021 01:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=mwM2SreNjinm5R/W2w3CxcJnRoqyfJkSmd4Ey8StaXk=; b=VkeBsqdl/8z1J9XCE2L0+qH8S1
        z3JWZgRMp6dp0GZmrqYdEUxwx2kWvmaYOdOc7PSrAbCxCSm8ecYtdwbCHGu97hjrndpN16VPphURD
        mb1WeBMHm9L/sWOZ7f98QBicDSj4i6zG7s4lXBCresk+A1w/wpN4mQH54YPjwSAQ0WE5J+O5XhnZZ
        AwtNHHow6UWwrz6EthuceC6t0kop2Wce32J+Vq7Wc8Xws9Lcg0E8HQW9E/dxZADeS3eQdIvqIFqQv
        9P0eKzeEm/XoXCJY3eHkxpNEBlqDCiYlRM+lB88NrUqjjXg5qsrYnVuWzu4blBxfkFNWrX0bJhIrp
        OFCDh8AQ==;
Received: from [2001:4bb8:191:f692:9658:56e2:eade:cbfa] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPLFs-004X63-3w; Thu, 25 Mar 2021 08:22:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: split receive_fd_replace from __receive_fd
Date:   Thu, 25 Mar 2021 09:22:08 +0100
Message-Id: <20210325082209.1067987-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The receive_fd_replace case shares almost no logic with the more general
__receive_fd case, so split it into a separate function.

BTW, I'm not sure if receive_fd_replace is such a useful primitive to
start with, why not just open code it in seccomp?
