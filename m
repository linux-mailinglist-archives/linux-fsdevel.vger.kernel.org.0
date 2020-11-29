Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8832C7786
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Nov 2020 05:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgK2EhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Nov 2020 23:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgK2EhS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Nov 2020 23:37:18 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5331AC0613D1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2020 20:36:38 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id j15so10561517oih.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2020 20:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qSqgo0diyYMJnfVubSHu3iSrO3muNitTzdW7zZJSstQ=;
        b=kA3r44LVTktioEzHeiRWWGwvEf0M1uIP0nJuH79y7vofVPbZWcxbCgP/gmSxe0j6sv
         vufcbAz3I85uEHvcENyNBibPfiDskvZN1CZzKuUaPR328682T2PqdBQxociWg1ApzkRE
         N2OHNua41q29TDmrnVVhqVoP3a4vPLr9D2r1a/Q3jS8ocl5h9PIbbif/FTVUiqcVfjhs
         4AIC8JelpZ+I3LVCDM3ua+gAXGVcf2keOAbfI7JuXV6TIYUgWvbh7hu8bWUPILwHATzX
         W/O5YlkKUVWYzSh3R5yUcFogYmBdrDeswwzbqvvhFwNBXLZ0bKUdqbXEgX9t1A7G7369
         Q/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qSqgo0diyYMJnfVubSHu3iSrO3muNitTzdW7zZJSstQ=;
        b=N/W40Y8LG5MPxVMZ7BBVE5jBOQ04Bp+9FBojsAsbpoI97Pp8YcDP9kzHmF3uNWBSn1
         Adb7s4+aeyCV4bqZJlZGiwmt4Ecbe1vlYndbvvx7at9FtT3drEEOc3mzOAQOgtg9ydjf
         pqjkKP8554Vco+CZL5C7vYjNSPmUepeYG0D8XgNWAUAJ6ct5unT3M8PGfINIBxiggEeS
         CAOKhK9y3+bUztxgMxn3GvIIBzvI5IUcnj3+ZjZo25eKIzO3526VvP2txaFh0GSLbCvT
         fzkQkmirYnj4aywDdeoffSu++s6HoxTf8gXg06xvI2cTeHk1qV43E4T4WCdx8SQBxcyN
         KycA==
X-Gm-Message-State: AOAM533wSFFXmmD1Tks0yQerdxErf9L0rMSZwy+Q8pObwwa4k/GtW7SV
        DAE2IBFeFviNok+IT64PABsHGI/3ljuDiz7xOZE=
X-Google-Smtp-Source: ABdhPJwI3MDqaIvldfOztxCm4put73JY3SkoxT3AVGSEax90AoUZKDzuYGnT4bif/+FGWuSsNnY5biAOoaQAFlmOKE8=
X-Received: by 2002:a05:6808:3b1:: with SMTP id n17mr10712069oie.139.1606624597578;
 Sat, 28 Nov 2020 20:36:37 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Sat, 28 Nov 2020 20:36:27 -0800
Message-ID: <CAE1WUT4XUmTz89cFf3eT4OFXRwgxwdre21KnAMJKcQ_iqzicQw@mail.gmail.com>
Subject: [PATCH 0/3] Migrate zero page DAX bit from DAX_ZERO_PAGE to XA_ZERO_ENTRY
To:     dan.j.williams@intel.com, Matthew Wilcox <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset changes the representation in the NVDIMM DAX driver for a hole
in a file. It was previously represented by DAX_ZERO_PAGE, which was set as
1UL << 2.

Patch 1 migrates to XArray's XA_ZERO_ENTRY and registers the new
definition for XA_ZERO_PMD_ENTRY, which is used in dax_pmd_load_hole() to
represent whether a file is a PMD entry or a zero entry. Patch 2 shifts
the bit for DAX_EMPTY down from 1UL << 3 to 1UL << 2, as DAX_ZERO_ENTRY no
longer exists. Patch 3 corrects the terminology used above the definitions
for the DAX bits.

I tested this under xfstests with XFS+DAX for a 20 GiB NVDIMM and did not
observe any regressions.

Amy Parker (3):
 fs: dax.c: move fs hole signifier from DAX_ZERO_PAGE to XA_ZERO_ENTRY
 fs: dax.c: move down bit DAX_EMPTY
 fs: dax.c: correct terminology used in DAX bit definitions

 fs/dax.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)


--
2.29.2
