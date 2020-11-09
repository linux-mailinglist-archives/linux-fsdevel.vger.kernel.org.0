Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD7D2AAEA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 02:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgKIBQH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 20:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgKIBQH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 20:16:07 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB29C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 17:16:07 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id u127so8606656oib.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 17:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2/k++WtMKcdAwUJoZnUHARNnkvDkyVkfviJV8vQ0AXc=;
        b=Sb/V1Rh5clTWSq/YDAk+HsgCFqbWxE6dcSidSePur9n/v0jNkJAmPLaOaFN6Bh/7ha
         X4Fv+8jzOhUTIOsFDlwGAwDB/eGAV6JBVzMWT6Zv/0sDsFr29ai8Z4+8Uh84ihWfeUBv
         rnd20sQN/vsVmzU/f00Gz0ABpMOH0XbIwB14V95zah3Xlr2wGoM9cWrbHC+CXo0z6I97
         DdfLHZR2oGnrhvCVN7VBw3XcJv2gdO+/IUroAYTe3GTBqiS8XJH7MtliGzkXoeOz6v5C
         QXAA7XOci3yZqTrF6QenpbIW37Zn6jJcBqhh757d8Lg559K8ZW1r/zRAe33+01e1F60s
         sVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2/k++WtMKcdAwUJoZnUHARNnkvDkyVkfviJV8vQ0AXc=;
        b=MOHnZeNsDYd3MFcJlg/Hqrhp6nMc5io5DwPapUaCHEwjZnhesF1LPmY23wAu1gs8Ly
         gWM4zSbeHTY8mR00D7j/E+XoeRa1XS4ffO1CQpJV2cw7VqnGhr7rkFUTSlNA3FBxnD8N
         WDkHiQibCB384RdwriewQrRu+JmNJF3+mQZw5AOuLoq/40srH1uReJZrW1Y8krorZt1t
         yYlMwxnLrmvJgQ3j+oIgp5smV3R7NVXUg6TE2P21aP9dOz6sfiDeS1StEKzEzP9OG8rT
         QUY4aBKfMOkaFdguv4fWScxD+EKnM0oVH7LgDsLEOFr4hJdeUBz+dybb1z6JWh+WVxVh
         2+oA==
X-Gm-Message-State: AOAM530T6/7jqeqwrLavSyCfIIkxoM+kW1cPLka168IwU69l+rGcURrl
        hPFZUFomOxcPjuo7ya4XaK0sWWzRQxrunEeFeWcwfnSGst/71g==
X-Google-Smtp-Source: ABdhPJzO+xGFTUHJ0xu9qUxdaV0uv2eHULnJc9pbzR/MzJWxzg5gALpbmiBlOBqy454JfLCwf+Q2xiG56xNDcJXPh5E=
X-Received: by 2002:a05:6808:2c4:: with SMTP id a4mr7341812oid.114.1604884566155;
 Sun, 08 Nov 2020 17:16:06 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Sun, 8 Nov 2020 17:15:55 -0800
Message-ID: <CAE1WUT6O6uP12YMU1NaU-4CR-AaxRUhhWHY=zUtNXpHUfxrF=A@mail.gmail.com>
Subject: Best solution for shifting DAX_ZERO_PAGE to XA_ZERO_ENTRY
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Matthew Wilcox <willy@infradead.org>, dan.j.williams@intel.com,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've been writing a patch to migrate the defined DAX_ZERO_PAGE
to XA_ZERO_ENTRY for representing holes in files. XA_ZERO_ENTRY
is defined in include/linux/xarray.h, where it's defined using
xa_mk_internal(257). This function returns a void pointer, which
is incompatible with the bitwise arithmetic it is performed on with.

Currently, DAX_ZERO_PAGE is defined as an unsigned long,
so I considered typecasting it. Typecasting every time would be
repetitive and inefficient. I thought about making a new definition
for it which has the typecast, but this breaks the original point of
using already defined terms.

Should we go the route of adding a new definition, we might as
well just change the definition of DAX_ZERO_PAGE. This would
break the simplicity of the current DAX bit definitions:

#define DAX_LOCKED      (1UL << 0)
#define DAX_PMD               (1UL << 1)
#define DAX_ZERO_PAGE  (1UL << 2)
#define DAX_EMPTY      (1UL << 3)

Any thoughts on this, and what could be the best solution here?

Best regards,
Amy Parker
(they/them)
