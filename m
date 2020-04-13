Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324DA1A66F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 15:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgDMNaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgDMNa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:30:29 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342ECC0A3BDC
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2020 06:30:29 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 60so8992750otl.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2020 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6jXC2UTWF/SUxZW/pWxyCF4hxNCly+ey/YhKERzLlbQ=;
        b=iP/ULyy8lWG1nhEGn0gppspS4F2JhILJ4nTAtiYGhdrZL51cxqVWhs6D3Y9wyc2ADf
         A2rwUCP45WAPoWNbSBZGTGVFxJmmDPHe19L3gxm7+w8E5f22GKJOLIMHoMQQI7v3c5XY
         DlMUV5+ZlbBmFxdLOO2VDbc7W9ESDWYt4QtLLqRZFkEOi9gTP3STkSTcSJo+WdBU2ZMP
         cbKcszDV9RPwFi/D+lHgC6golJOLYJdAkURkw7hbGoqznT8eWbtFkjjpTaIqirsxJh7L
         wdqYlNLP395ub4iQIUl47edMIk3+i+NAk1eC0wEHnaBVffHHOQq3Dv9hRllCWWuEG7fQ
         v+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6jXC2UTWF/SUxZW/pWxyCF4hxNCly+ey/YhKERzLlbQ=;
        b=egFaAo3Y6uBx8pTfW2xTgsP4bCaefr6jDOVU6K0vIhq/nnzVoavI39VO6075bMSSyd
         M4vH6ya7w6CIrfIlEPvP9HcqnO/IBJ8nRkdfjqdG8+l+4LM6h3IkkHcKOLlF4FQSnf4z
         cNc35+RbitDOgbJivS1D2aM0CMfoBUv6c5/73Ss8PjxA5YpO4Vnhe3jY5A7UjJO+wZFC
         b/W4g2iVCz+aaNbUFIWijyF4h6kzEXpyGyatVQR4OUx3LaZyZydia/7Tw6psGs1UUglX
         SVN9qYrUIOmvRjTcPm/wYwjW28Xvj+CV0iKayhrxqyD2MeKtxEbyq0YSA/6qoRm6DG0G
         aPGg==
X-Gm-Message-State: AGi0PuaAAlJkGRTuDwulfIYNv1+WzX2iUfzstCZF2TMKu6eCsNy6ByCj
        SgvkeJwxycwb0/cwB9NKVLvYrcBMz3eSlBiHeW+4pQ==
X-Google-Smtp-Source: APiQypLFU/9OTkw8I8yoSnsZBoCJl2kmbnPrqcYyRtFa4kS0eBylKtgliJY99Emg2IXzWabr7J0d9UY0bd1bcIemaS0=
X-Received: by 2002:a4a:da55:: with SMTP id f21mr14363752oou.34.1586784627519;
 Mon, 13 Apr 2020 06:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com>
In-Reply-To: <20200401213903.182112-1-dancol@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 13 Apr 2020 06:29:50 -0700
Message-ID: <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>, jmorris@namei.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 1, 2020 at 2:39 PM Daniel Colascione <dancol@google.com> wrote:
>
> Changes from the fourth version of the patch:


Is there anything else that needs to be done before merging this patch series?
