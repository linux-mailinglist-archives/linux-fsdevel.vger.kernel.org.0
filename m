Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BE73F6FD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 08:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbhHYGvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 02:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238276AbhHYGvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 02:51:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450F2C061757;
        Tue, 24 Aug 2021 23:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+i/JYgkRJLs3S1XvjipwzCegOl0l6Le2bbTKegrGXik=; b=jQSr+KYsg9+T+pRrD9QsDesg1U
        bH77iJSwHTRnHFp0Y+hACM4OcYKbqdbdgY4p4v1d2XZAQqK0XmdgYmPek69cwSPOrHCduckAbpL0N
        SCMMh9KsXKfjcOOA7lU9BWvWSdJlEwFiae4eqOFfoeWuEbvSJBr5vP/8d1xTdFDqa0V0XQO1qt7dV
        X1XBWeQR3/F1Z61uVP5mzwDGLLWiW832Kf2rYQOxMasP595MaW1ZvJSF5cLtYulgXpcdOKNa5D+Gr
        7hf8hqW7eIP/oaMrMINf5t9ixb7msDcqMp6XxhzbQYffQdTy0SsrShOe/oEjTnIhBaVUPqa0YoItE
        ITdNGWKQ==;
Received: from [2001:4bb8:193:fd10:ce54:74a1:df3f:e6a9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mImij-00BzYa-Dn; Wed, 25 Aug 2021 06:49:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Joel Becker <jlbec@evilplan.org>
Cc:     Sishuai Gong <sishuai@purdue.edu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: configfs lookup race fix
Date:   Wed, 25 Aug 2021 08:49:02 +0200
Message-Id: <20210825064906.1694233-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series takes the patch from Sishuai, with the initial refactoring
split into reviewable prep patches and the suggestion from Al taken
into account.  It does not fix the pre-existing leak of ->s_dentry and
->d_fsdata that Al noticed yet - that will take a little more time.
