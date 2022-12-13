Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABD364BB01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 18:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiLMRal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 12:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbiLMRa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:30:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33E02126F
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670952582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7aOzaH8w1oPNGJxdFvZ299A/3LW0IWhj+uSH4co6uo=;
        b=Sfn/uPTavwIbXoKuto3CiPB1cGl6GbhtQIcZt5QeikF6F5qHpxkX6sz483hV6IOtGTfMIr
        EJBfNHnTSeXN9Krnm068Ek1sKEXXyegpmmIY0w5Ncusmx9Kys/FrD9k8f9ogJrWhDEvWf5
        Zbtfk+ZH+1ejG/Ept8mPX9CkYP74fJE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-64-3aRh06ULPViHELg_FhBiNg-1; Tue, 13 Dec 2022 12:29:41 -0500
X-MC-Unique: 3aRh06ULPViHELg_FhBiNg-1
Received: by mail-ej1-f69.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso9706123ejb.14
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7aOzaH8w1oPNGJxdFvZ299A/3LW0IWhj+uSH4co6uo=;
        b=lUosU9kEYGxRd0zoDEUodnxz2HuF7GUYa4sz8vHaCXuxl7tFHRIHGCxNdLYHetK3xF
         LmQBBh71nmDgXJN/iZItx5HrRJk97ZbjU8LPpltRgbTxiTuykViYloduDCpzLuaFyYOI
         peBAw8sbL0ps5cawOmI2oQG/LAMa3dYFtHofGologyhFE0PnS+j7om6OPbw5D1FdLLja
         bSVMDU6EZ9IOxmgd+NBNMwF65+jQqhdcXkz1hXUWH2fyPV/1ysUw4vR3ZLPb60KkdcSI
         43+c83HQqChIInP+pECtVd4NDjnm2V+wTvPJ9ttz/+UP9pAO4XY9SqyTPJh33C0kEylC
         vYEQ==
X-Gm-Message-State: ANoB5pldVJlTjD8N6z5Jy4eCzICG3Mk/nHWIct5E3uRnBXPUIKaykOkl
        0Zhh1qno/i9uxckTDYbo5/AsDD7HEludmhXafzwfxVDtgusuv2AboJQ5mZ9nQwQnf9MOhPA1RMj
        c80k6D43NCTE3QgdeOf/870g/
X-Received: by 2002:aa7:d4d6:0:b0:46a:a94a:e424 with SMTP id t22-20020aa7d4d6000000b0046aa94ae424mr18886511edr.40.1670952580568;
        Tue, 13 Dec 2022 09:29:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5aVRp2Bd9Ma/3Z+2HR9K9G5JRA0WyHS7yqf2ie0nMXqV9Ii28qX8GFd8o1XgjlG6pHoLu+qw==
X-Received: by 2002:aa7:d4d6:0:b0:46a:a94a:e424 with SMTP id t22-20020aa7d4d6000000b0046aa94ae424mr18886502edr.40.1670952580439;
        Tue, 13 Dec 2022 09:29:40 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ec14-20020a0564020d4e00b0047025bf942bsm1204187edb.16.2022.12.13.09.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:29:40 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [RFC PATCH 02/11] pagemap: add mapping_clear_large_folios() wrapper
Date:   Tue, 13 Dec 2022 18:29:26 +0100
Message-Id: <20221213172935.680971-3-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221213172935.680971-1-aalbersh@redhat.com>
References: <20221213172935.680971-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add wrapper to clear mapping's large folio flag. This is handy for
disabling large folios on already existing inodes (e.g. future XFS
integration of fs-verity).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 include/linux/pagemap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bbccb40442224..63ca600bdf8f7 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -306,6 +306,11 @@ static inline void mapping_set_large_folios(struct address_space *mapping)
 	__set_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
 }
 
+static inline void mapping_clear_large_folios(struct address_space *mapping)
+{
+	__clear_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
+}
+
 /*
  * Large folio support currently depends on THP.  These dependencies are
  * being worked on but are not yet fixed.
-- 
2.31.1

