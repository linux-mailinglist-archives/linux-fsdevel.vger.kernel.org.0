Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37F81A740C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 09:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406285AbgDNHD1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 03:03:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406215AbgDNHCH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=77D1XXRWkuxqD9EgsqFvBl2GVjPwcFnlwZ4H5QeKf8g=; b=k4J2N/j3r3k8rtX6J9OJVuyI/B
        Y/lP14ZAwAwAT+sXF6iSJZ7ASkdNoGavrhLf4SxqyRpa2OOaUsmOzNdSgpuMsZdrrc4HvhlAEFo6b
        CCobuvFapWEVgmmPConT4NvC8iJNZsDtt7TmeAFbHEiIFxc4pOViS5uJuA9eKcZ1YLFo8rU1xATNc
        7jiVWmya/Lqbc2aONf6lZe3mQgKP2ol+a2aOWYinwhbJfGu2Bup5vo1BCn4zkThGhmyTPMs2dpbgm
        OUtUWfHYOwAT2kAEC0lHtnGO8aIpQsX1LeXu1KBN5ExPzd35dPommBeIn41XPgbKi10y5lDc0DARp
        aeCnc9Hw==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOFZo-0005Xi-T4; Tue, 14 Apr 2020 07:01:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove set_fs calls from the exec and coredump code v2
Date:   Tue, 14 Apr 2020 09:01:34 +0200
Message-Id: <20200414070142.288696-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
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

Changes since v1:
 - properly spell NUL
 - properly handle the compat siginfo case in ELF coredumps
