Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3F2398E35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 17:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhFBPTw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 11:19:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50218 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhFBPTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:19:48 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 303BB221A2;
        Wed,  2 Jun 2021 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622647084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zEcvJJtB5ZZ8X3Pwr4CJiFmKxs/RV46XyrbByZQvcmw=;
        b=W3Ww4J5poIByE64fCgmyHc95Wyw35z4mRgRPLiOk4cqvsyT7tUWNXYlvX6s+V8z6ofNCV2
        g0bK57XsIM7kY5JrnuVVdbjfahksiqc7189MK+M6uQcj2f/Yigz54+P6IJK59igA08Lo9y
        y+e3AWuznpGWfr4Wov1z0sli1NprVUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622647084;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=zEcvJJtB5ZZ8X3Pwr4CJiFmKxs/RV46XyrbByZQvcmw=;
        b=EgM3xWO6z/2DscKQOGkz/i10K1jO2LRaLUduTQyFdz5FxulhYb1LHVYqYpEoKjf6RCA1GK
        UCd8QZ2ZvHD/WCDg==
Received: by relay2.suse.de (Postfix, from userid 51)
        id 2BB72A3D80; Wed,  2 Jun 2021 15:25:59 +0000 (UTC)
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 52C40A8176;
        Wed,  2 Jun 2021 15:15:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2F5631F2CAC; Wed,  2 Jun 2021 17:15:59 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, brauner@suse.cz,
        <linux-api@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] Change quotactl_path() to an fd-based syscall
Date:   Wed,  2 Jun 2021 17:15:51 +0200
Message-Id: <20210602151553.30090-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=577; h=from:subject; bh=RQHeSUZ+8nnut0tpFXDRWIhRsMEPE1l7gaYEIo3rNl0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgt6BpWVcA/jt1oYfBDnI31q0Bb0o/KMoZpkwUa3jK gPPGwEWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYLegaQAKCRCcnaoHP2RA2V+lCA CP5A97MOvTgVeC1nr0NnO0QcmY91OFryXrfL/4WVhLuRcV1jCM+JQjvF0VODAF99fawsvh98mzPsGS 51Cw7R7xe+OLmjks8YQD1soFwnSFhlym3CxvOnxs1tbOWS3A46V6ZZZg10yxVBWMLeJCb+ppKBdzsA saUpfYWvsmxhFDyjDliqslME7y97xB2iH8TFyu6LuukIAAGmknsVUPIubXe8vGF3JyS4VeUK1ov2c8 y7d65GlhXWFdHZNMgiV8SHVeLO5/f1GFdnJkBWyg0gtBpCMVu0IMsVLDL83FaGACAjGLOKT0RRFIEE a/Y/Mq3pUjWlMHFRaYze3FEytUTBza
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this patch series changes Sasha's quotactl_path() syscall to an fd-based one
quotactl_fd() syscall and enables the syscall again. The fd-based syscall was
chosen over the path based one because there's no real need for the path -
identifying filesystem to operate on by fd is perfectly fine for quotactl and
thus we can avoid the need to specify all the details of path lookup in the
quotactl_path() API (and possibly keep that uptodate with all the developments
in that field).

Patches passed some basic functional testing. Please review.

								Honza
