Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631621C52C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 12:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgEEKNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEKNM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 06:13:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED89AC061A0F;
        Tue,  5 May 2020 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ncJk3Hy4dw1GXdM3XrwfaxwhaN20YHNFbgRW0igSO6Q=; b=Z68OL98GDKc9lPf5hyO1BAr5o+
        xMc+UIPj/LuL8Rh036j/7iay/ncZhMMEomofD47iiQ2PEry3DUdts8KqP7yn0UXPdzUojC/Zea/Xz
        RL/yW8xYZ9YTrRkjzIdd3FfFEWNNfXuDWzHtU54QvIb6IAI6mLBLvSIgfBMFebmGBYzL+hoslZZy9
        uGKWiRILrNEm1OzKlQ2wneeYp3AOOvHorPebbsHrrpgh1vDGbx7MGQStlRVJtiONZEHuhFZUK1lmU
        fjXpuvLGt4F7u3YkXV5yRj1FfP4y1j/KsoZnrTPXE94r2dkn7MUF5FM3SM1SPAMIRnmp+WxYRyPkj
        i4QEV0IQ==;
Received: from [2001:4bb8:191:66b6:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVuZO-0006tK-Hs; Tue, 05 May 2020 10:12:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove set_fs calls from the coredump code v6
Date:   Tue,  5 May 2020 12:12:49 +0200
Message-Id: <20200505101256.3121270-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series gets rid of playing with the address limit in the exec and
coredump code.  Most of this was fairly trivial, the biggest changes are
those to the spufs coredump code.

Changes since v5:
 - fix uaccess under spinlock in spufs (Jeremy)
 - remove use of access_ok in spufs

Changes since v4:
 - change some goto names as suggested by Linus

Changes since v3:
 - fix x86 compilation with x32 in the new version of the signal code
 - split the exec patches into a new series

Changes since v2:
 - don't cleanup the compat siginfo calling conventions, use the patch
   variant from Eric with slight coding style fixes instead.

Changes since v1:
 - properly spell NUL
 - properly handle the compat siginfo case in ELF coredumps

