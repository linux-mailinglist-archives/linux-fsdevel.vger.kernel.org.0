Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797403AE31C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 08:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFUG3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 02:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUG3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 02:29:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6C4C061574;
        Sun, 20 Jun 2021 23:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Dt1tYSfWAid43wFWr7JNa2FzhmQeXcsREodQskAi2r8=; b=mLs7UUmUS/ByLwI8Aed5Zb49le
        0A2x/nG+9AHCfw1rP93d8QW1PVPT9sy3sfgZFIyENtc4khSxaEh9H56aMbTWgF6quSdlIi+B36MGy
        fUhCFOPVfQvxEurlzj+a2RD/FuwP1UvyJ/lCn4devsFpMRxr10QYoJc7A8ZwRCagtjzy2sML5rO26
        kou9gqh/L58tBghIQr+lu8PqyWY06+KJINT1lgI78ck5jqKM5kl5V2m8D/bPe98LMRotkniaN9rym
        9XyC9v3wfBaIFvMHZthZy8NcOzXh3eG15W4Uheg5IpnTKfpIYZ69s8ZK+RN6lQCYMTu/iscL3UnZG
        hP4Y7svg==;
Received: from [2001:4bb8:188:3e21:8988:c934:59d4:cfe6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvDOd-00CmpC-P0; Mon, 21 Jun 2021 06:27:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: support booting of arbitrary non-blockdevice file systems v2
Date:   Mon, 21 Jun 2021 08:26:55 +0200
Message-Id: <20210621062657.3641879-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series adds support to boot off arbitrary non-blockdevice root file
systems, based off an earlier patch from Vivek.

Chances since v1:
 - don't try to mount every registered file system if none is specified
 - fix various null pointer dereferences when certain kernel paramters are
   not set
 - general refactoring.
