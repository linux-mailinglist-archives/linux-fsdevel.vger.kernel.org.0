Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06D91F012C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgFEUsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 16:48:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:47726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgFEUsq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:48:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B5C6BABE4;
        Fri,  5 Jun 2020 20:48:48 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     darrick.wong@oracle.com
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com,
        linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: [PATCH 0/3] Transient errors in Direct I/O
Date:   Fri,  5 Jun 2020 15:48:35 -0500
Message-Id: <20200605204838.10765-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In current scenarios, for XFS, it would mean that a page invalidation
would end up being a writeback error. So, if iomap returns zero, fall
back to biffered I/O. XFS has never supported fallback to buffered I/O.
I hope it is not "never will" ;)

With mixed buffered and direct writes in btrfs, the pages may not be
released the extent may be locked in the ordered extents cleanup thread,
which must make changes to the btrfs trees. In case of btrfs, if it is
possible to wait, depending on the memory flags passed, wait for extent
bit to be cleared so direct I/O is executed so there is no need to
fallback to buffered I/O.

-- 
Goldwyn


