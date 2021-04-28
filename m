Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2905F36E1B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 01:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhD1W0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 18:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235132AbhD1W0U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:26:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 621E461448;
        Wed, 28 Apr 2021 22:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619648734;
        bh=bc51XLzoIStqnoVTY2IJKBH2Xkj7e3O8EbUO/HRXZk4=;
        h=Date:From:To:Cc:Subject:From;
        b=ne3oFiliuKEqZvqRvRzJ/joF+ploVyTKGqAL1cvEbIbxYKAKLmKORq3y6WYRfvDzt
         5ijg+enNweA0yissVsE9cqg8XgrROj6zGRUEs0GF4E7/9lPdHZa/qRo+s20jKdYmE2
         /s8EJJlX5oj3MZqGfnr2K5XBMhViog+gflPI9gvJEH+k76G+bZlu1Ieomqp03z5sA3
         5qdxfhKj9Cf6v3mZs+lNSggANx+ESdV4x4gcxT8URLV5IHhOhuh5NEBY/RMAb+Q1CW
         OywMoMY81JxKMj7wGhPvRN2YVoNIakacpnE2Bikk18zvpRKdkMEQICdxSFwBz8ei2d
         SpIO6+nR5C27Q==
Date:   Wed, 28 Apr 2021 15:25:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     pakki001@umn.edu, gregkh@linuxfoundation.org, arnd@arndb.de
Subject: [PATCH] ics932s401: fix broken handling of errors when word reading
 fails
Message-ID: <20210428222534.GJ3122264@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

In commit b05ae01fdb89, someone tried to make the driver handle i2c read
errors by simply zeroing out the register contents, but for some reason
left unaltered the code that sets the cached register value the function
call return value.

The original patch was authored by a member of the Underhanded
Mangle-happy Nerds, I'm not terribly surprised.  I don't have the
hardware anymore so I can't test this, but it seems like a pretty
obvious API usage fix to me...

Fixes: b05ae01fdb89 ("misc/ics932s401: Add a missing check to i2c_smbus_read_word_data")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 drivers/misc/ics932s401.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ics932s401.c b/drivers/misc/ics932s401.c
index 2bdf560ee681..0f9ea75b0b18 100644
--- a/drivers/misc/ics932s401.c
+++ b/drivers/misc/ics932s401.c
@@ -134,7 +134,7 @@ static struct ics932s401_data *ics932s401_update_device(struct device *dev)
 	for (i = 0; i < NUM_MIRRORED_REGS; i++) {
 		temp = i2c_smbus_read_word_data(client, regs_to_copy[i]);
 		if (temp < 0)
-			data->regs[regs_to_copy[i]] = 0;
+			temp = 0;
 		data->regs[regs_to_copy[i]] = temp >> 8;
 	}
 
