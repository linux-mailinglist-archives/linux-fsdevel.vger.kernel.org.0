Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBC83239CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 10:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhBXJqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 04:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbhBXJp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 04:45:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E9AC06174A;
        Wed, 24 Feb 2021 01:44:49 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b3so1222602wrj.5;
        Wed, 24 Feb 2021 01:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=LfcmABgWCle95IJI4lRPY0H0SCG46K15H2+YXiVhLLK2XnLsnZYJlaHg0xEgWkC3Fa
         LcfTMC13L6nuBlCI047AP2Ke/uJ+1fQnI6tWg80V8tT3OmVkNIroB5mlgx40XsHAeEU1
         C5bJQz22wSm4Vx1Lo6bvM1i6wFTnuMlNGmP3wJEz494b8d6ZIDbI26YjpzKyjFsH5HYh
         WM8zy9TwMLcZ848S4sNAENIU76UUfl7wn6242IqDwwQTRfIBtDzERxbS3MJJ/96I0Ynj
         hMy+n7m2+vSzunPR3oFX7gC5GilvYN156W/6i6w04L6fNok+6D2ijWTuXyXIi70ikLb2
         IOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=DHXoOZx9xc+jXwBB4AJvvx+VbXOQ7XhghCS/PzrvEBAcxq586PxsILRDLXPyDyTfBU
         S4FS48kXQWCDASBWw0Q5BPftiTTl0LY6PYZ5H9ORhjhXpQDXy9SmGqfM4PsZIYGzT9nf
         biikyDh4uUoSfNiuGHG8dCQmq6zyjUGZwP0D0sLLN9u9IPYPIrXGMRN4+pMa0YslMRMI
         crCp+8ePBjLwJs6cSbNTqqMVUaf7Mm99ux+DBmceoCTqrwpjWR5X76f8GLZHNDdZI1sI
         oXcIrOd1YJrn83FfX15BRwFcYtfxe2jw9jOd79wKuPMdsytJI7+cg1SbjWQNysgm32qy
         iQdQ==
X-Gm-Message-State: AOAM533nr9XwWAksf/lNDxUYs+96wSQLYG8fYW2gsvBZjdWfrHRfv2R3
        oINH7ErfCRI2XRSWRYayOC4TKzdwANLoKA==
X-Google-Smtp-Source: ABdhPJyKwoLFcFECkDb3rYb5PpKY4OVBN0ENzwVGLX+YlzZ21VrTgTQVM4/YByVL0Prmd9Uk25IPVw==
X-Received: by 2002:adf:f589:: with SMTP id f9mr28757237wro.159.1614159888311;
        Wed, 24 Feb 2021 01:44:48 -0800 (PST)
Received: from localhost.localdomain (bzq-79-179-86-219.red.bezeqint.net. [79.179.86.219])
        by smtp.googlemail.com with ESMTPSA id z11sm2968269wrm.72.2021.02.24.01.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 01:44:47 -0800 (PST)
From:   Lior Ribak <liorribak@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        liorribak@gmail.com
Subject: Re: [PATCH] binfmt_misc: Fix possible deadlock in bm_register_write
Date:   Wed, 24 Feb 2021 01:42:37 -0800
Message-Id: <20210224094237.122929-1-liorribak@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201224111533.24719-1-liorribak@gmail.com>
References: <20201224111533.24719-1-liorribak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

