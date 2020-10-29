Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A997829E8A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 11:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgJ2KMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 06:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgJ2KMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:12:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E3BC0613D2;
        Thu, 29 Oct 2020 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HZ8TaPb14jta9j4bcrtWFgktOhAKRClMadxsO4T8de8=; b=VdcRykTjOvo/GkkbH7WQ1gIp1T
        o0EPr73DnEcGkk13CfXBYBzZ7thU2nKryhAFanT33rN28lziv+mC1Iq3iqQd6tDwFaj5KGJYeREWJ
        6hPgeV455iTnquqqS5YRe9J0qOuNK9xZMZBEoEKGQYi82jvLR2Cr1kRRBGl5VmXVdsQv/ud//tbwq
        9UAkhv0ie0oFKRDbx4DsjlwtIK9cXevNxrsOoAL8HilkZyPef5FQGNv4dhVgoG7fdEoSfyeyHPUu3
        zW6RbXF7u66Ica23RXUqx8cmAFMO+aESYKGvgXD5G0GnQMCCYVXRXIv/LOI+nR1cWgM/BFgmqOBfY
        pu6NgVHA==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY4uY-0003gB-Ho; Thu, 29 Oct 2020 10:12:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: support splice reads on seq_file based procfs files
Date:   Thu, 29 Oct 2020 11:09:47 +0100
Message-Id: <20201029100950.46668-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Greg reported a problem due to the fact that Android tests use procfs
files to test splice, which stopped working with 5.10-rc1.  This series
adds read_iter support for seq_file, and uses those for all proc files
using seq_file to restore splice read support.
