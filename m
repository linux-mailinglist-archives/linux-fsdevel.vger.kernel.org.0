Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9FD2FC9D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 05:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbhATES1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 23:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbhATEMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:12:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB52C061575
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 20:12:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id dj23so21567905edb.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Jan 2021 20:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l9avflWFeErte6PCdfopkFmndIBocFK+Q/nYZfMSQqE=;
        b=C8X9zRKkt17O637vlA0w7Ei2ZWLSxfOvwrDoOnZpbpLWanHhida3po4heO9YLgkL3h
         g2rrWM4q75sYgbOcuT7R8Ysq6PNPhyXKwYCrjVwhODO9wH7K/Gp58yjltLJy8hTUDhcW
         mhLTWMHNIL7Yw9j/eKbhiPuLvflwpUv1jEhGT8drp9zHGpHcuTWMTzmgCQdBAjeu4ehj
         JlUn/H9Jv4OVBsFlsxG5It9Y90VjsRyGEnCvK8hN94PMvlxdcocSL8tIcgPUxTKL+uPo
         8Cvia917hnJtJNAsi9qYcfBvhbbNHwORUEA86Z5/h++2U2xB5oXsd4p+RLPy9O13E7J3
         CPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l9avflWFeErte6PCdfopkFmndIBocFK+Q/nYZfMSQqE=;
        b=g4rceV3ImXJ+qem6J0jC6osClkx+oM7mDzu33L+j1hGQEEh67Ck2SaqbGH0YyHLwRG
         ViNbf1qQT+UtTWEg4JoYrELnfnBPrhCaYsj1Ubhyu2TnvOwLOhI8YRs8anDv2JeKrrtU
         /R65teJT7JIChYcFwus6QgBT7NI3faK20vA/LGPCz1kmiH+tqJQv3KSS3hogDKsKT+zC
         mJdCuigOOMWPUkOkSebhxlLaVsXZXNmpGxRwcBr2INpHWyZZZ5eCw30HX/gMXIk/srx/
         Cp56OXh95SXJ985Oal3za0Ri5MCVrC6X/joqS0yeT3HfEbULn0lbmD1tYqxyiCSJc1h0
         CUNQ==
X-Gm-Message-State: AOAM533ORTXYoFvYklhG8Q7uTOBx9KEKBY7F9rcZ6EMuee/JvZt3h9lY
        GKRMN895bAAN424mnPP2KdGm1Nb7rp9w+E1JcRxGtQCDPH0rBA==
X-Google-Smtp-Source: ABdhPJxaTZmcMRWRWf1kOl8EoB4XcBiaPjcSic8IErTq56RdAQHmLAtfGaZyRwaI/gCzOTN5YYo0k2RdctfiDacqV4Y=
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr3750536edd.52.1611115929077;
 Tue, 19 Jan 2021 20:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20210119213727.pkiuSGW9i%akpm@linux-foundation.org> <5f8e2ede-5836-45e1-d8d7-ae949775e76e@infradead.org>
In-Reply-To: <5f8e2ede-5836-45e1-d8d7-ae949775e76e@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Jan 2021 20:12:01 -0800
Message-ID: <CAPcyv4iX+7LAgAeSqx7Zw-Zd=ZV9gBv8Bo7oTbwCOOqJoZ3+Yg@mail.gmail.com>
Subject: Re: [PATCH -mmotm] mm/memory_hotplug: fix for CONFIG_ZONE_DEVICE not enabled
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.cz>, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 19, 2021 at 7:05 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix memory_hotplug.c when CONFIG_ZONE_DEVICE is not enabled.
>
> Fixes this build error:
>
> ../mm/memory_hotplug.c: In function =E2=80=98move_pfn_range_to_zone=E2=80=
=99:
> ../mm/memory_hotplug.c:772:24: error: =E2=80=98ZONE_DEVICE=E2=80=99 undec=
lared (first use in this function); did you mean =E2=80=98ZONE_MOVABLE=E2=
=80=99?
>   if (zone_idx(zone) =3D=3D ZONE_DEVICE) {

Thanks Randy. Apologies for the thrash, obviously the kbuild-robot
does not include a CONFIG_ZONE_DEVICE=3Dn.

I'd prefer to fix this without adding ifdefery in a .c file with
something like this:

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0b5c44f730b4..66ba38dae9ba 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -885,6 +885,18 @@ static inline int local_memory_node(int node_id)
{ return node_id; };
  */
 #define zone_idx(zone)         ((zone) - (zone)->zone_pgdat->node_zones)

+#ifdef CONFIG_ZONE_DEVICE
+static inline bool zone_is_zone_device(struct zone *zone)
+{
+       return zone_idx(zone) =3D=3D ZONE_DEVICE;
+}
+#else
+static inline bool zone_is_zone_device(struct zone *zone)
+{
+       return false;
+}
+#endif
+
 /*
  * Returns true if a zone has pages managed by the buddy allocator.
  * All the reclaim decisions have to use this function rather than
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c78a1bef561b..710e469fb3a1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -769,7 +769,7 @@ void __ref move_pfn_range_to_zone(struct zone
*zone, unsigned long start_pfn,
         * ZONE_DEVICE pages in an otherwise  ZONE_{NORMAL,MOVABLE}
         * section.
         */
-       if (zone_idx(zone) =3D=3D ZONE_DEVICE) {
+       if (zone_is_zone_device(zone)) {
                if (!IS_ALIGNED(start_pfn, PAGES_PER_SECTION))
                        section_taint_zone_device(start_pfn);
                if (!IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION))
