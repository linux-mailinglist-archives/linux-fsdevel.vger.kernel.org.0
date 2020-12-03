Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E972CDA56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 16:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbgLCPsC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 10:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLCPsB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:48:01 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE22C061A4F
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 07:47:21 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y10so3020674ljc.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 07:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ayfcs9PdWYm7lbPtI7skq4RBm0f2Hr2bSO79nAHtFc=;
        b=qeNyZ8YsBRIcSSEnxPslZwdaQzbHNHWQrVBr58zRszE0F8P9QlO9s+F6Eup0AC7FxW
         QCI9RwkC5r87S1DcMFuQ0LGorDW6hc5tvP0HfgHeOOAQ4yRiIDrmcnabMErr46z25doA
         KuS+R05984StHPoMfsXc6p3fX8UtHh/OTtoHz+R5rvw8+PEVFCbi/ODbvauIcTOeBy/l
         LjY8bfJMs0j0jbctFehRcbnTYB5vfU33O6FRUX3G3dJeEzqE4yjZP8cwtzrXBtIu4V9x
         qG8OhxlOwT0sXfEVrrlcH+U1SXqjVUNsoLXauBwPRBppDacfBHal0+6hTivZDoWfPiUF
         I5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ayfcs9PdWYm7lbPtI7skq4RBm0f2Hr2bSO79nAHtFc=;
        b=QWKvDGtDUcBUqioZw8xvUPxGRRe2SNXxBNKuKtPg854IidKho6o7HT/VPFW1b5rAaw
         I+gIXwQfiFwbG5L12G4invOt4StmwIi4l3SX18vEYsq4he7PrjGYQ6Tm+6g3L/QzeTZg
         BG5tiA5PAGVpo9IjVGlxu8yrCzhZQnHtK29NDrnUFqpas6muBU6p207W91jIkyRllFxT
         UlI/eYpS/O1EdzIheHszQzGVWtOSfGXFxHrGXiHamExDTGY5+KsGy/2wv2Lo/LcMa1ET
         geRSEhuz1JZuM6DRrl8YowL60rE+3XlE/a6TS+2NgVB8887gzWJAKOH8B3qL8/vaDNQQ
         /3vg==
X-Gm-Message-State: AOAM530+g1cxZbN+OBQ5r9QlFkQKDeno6ZbB8keCBGsiJabicCPdIrOo
        MsisszcXcze5CvkjMp1ShMNMNZ67wLblzmIy3PaBXQ==
X-Google-Smtp-Source: ABdhPJwIWQzmwxHBiRB8EE+s5XaHTO5aY/OfRodwgESsla0us6E0o0PYvgEf52SU6B5EtE5PNDOv6vNy/ZwtEjOqjbg=
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr1526064lja.192.1607010439133;
 Thu, 03 Dec 2020 07:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20201203062949.5484-1-rppt@kernel.org> <20201203062949.5484-8-rppt@kernel.org>
In-Reply-To: <20201203062949.5484-8-rppt@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 3 Dec 2020 07:47:07 -0800
Message-ID: <CALvZod5-r+TmuAYS7ErpSPdF0RKN_F_CbNMoXQdqONbhPxunTg@mail.gmail.com>
Subject: Re: [PATCH v14 07/10] secretmem: add memcg accounting
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 2, 2020 at 10:31 PM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Account memory consumed by secretmem to memcg. The accounting is updated
> when the memory is actually allocated and freed.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
