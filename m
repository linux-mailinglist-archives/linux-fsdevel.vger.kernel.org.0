Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9438F4C6C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 07:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfFTF2u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 01:28:50 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42118 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfFTF2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 01:28:50 -0400
Received: by mail-yw1-f65.google.com with SMTP id s5so635431ywd.9;
        Wed, 19 Jun 2019 22:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=975n1pRlZvHWVrvlkCM9JYyTq8SwMn3AiFj33aMVVOw=;
        b=vej6/UOM56QFAi4RyCek7x+FHM10VJXhjV/yBMJfwJ/eLHPl/9xBs6cjl3YT0ZR13b
         aLvZKSyg9FIFJ9XFUBMDs5FqqLuaCi6s+POOE+WWpxjo1V617a5seaK8iL+wKpEdb/tK
         wakna1lltAvzWri0DuT0nSEomO1/NOc41gFdYhQPTgCuajhMt7t9Umcnh/SP3aSG1VOy
         o1wbGss0XoZpSb5ygcqJSa7lkutA0d14zDv7LLlbSZVd2YTjiGUt2R8oIWy5BPCmaDew
         bmxSGV8z5XsBfXo55pM6kktBgRr19wB8GVY+XFwtsIVjd8MgNdzDpFZd5yKIFo+vdViy
         55HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=975n1pRlZvHWVrvlkCM9JYyTq8SwMn3AiFj33aMVVOw=;
        b=Ut16fV0yBrxZUc+s2+FwkREG4JUc6teC7gAUlH78XRtzEqwWx7IiYZI+2tkdcSYb75
         LPgGkCqtd8lcgPZN8/dVmKVvk/JOIPBKZjYr5EQkoEOquNBZALJyhnYvMFgWXRJ4CPRq
         EVGzEs/tj7SgsURoPaIdYst6UHruXpHiSVd4p2KuujbkZ6ZPvR49KHzEkRzClwT6iGWN
         L/pUtrDoOeYjpuYT3QkeUMn1QHwncu5+fZhZccLfczvX2XY/Z2LafruSEzfeFIkga7yZ
         rxNccG/zvCzN5eYb+svxFnIsw76wxubDKpPm/nmxZSvqT1k4iPE6Q9hof/KgBxvouO8U
         7daQ==
X-Gm-Message-State: APjAAAW69uyvTqQJFVftjtF7vDAThF77eC3ozKVswlag8zsThr2TWK0t
        oa09pneZEm3RG8CMWFPlM1bpNU/Dnn7I9tlrdJk=
X-Google-Smtp-Source: APXvYqyc/TU+xc17P9uKRN/o3l801PdGZD7XU2NmiikDAEG+lkR5IHdIyZnss8a9qeKHKIpBeaJc2SwfWgFhaSSjr4o=
X-Received: by 2002:a81:50d5:: with SMTP id e204mr18579529ywb.379.1561008529213;
 Wed, 19 Jun 2019 22:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5ms8f_wTwBVofvdRF=tNH2NJHvJC6sWYCJyG6E5PVGTwZQ@mail.gmail.com>
In-Reply-To: <CAH2r5ms8f_wTwBVofvdRF=tNH2NJHvJC6sWYCJyG6E5PVGTwZQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 20 Jun 2019 08:28:37 +0300
Message-ID: <CAOQ4uxhC9x-quL0O9CYaqQ6_uX3yW_3PgW=a68AJboB4pjqz1w@mail.gmail.com>
Subject: Re: [SMB3][PATCH] fix copy_file_range when copying beyond end of
 source file
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 20, 2019 at 4:44 AM Steve French <smfrench@gmail.com> wrote:
>
> Patch attached fixes the case where copy_file_range over an SMB3 mount
> tries to go beyond the end of file of the source file.  This fixes
> xfstests generic/430 and generic/431
>
> Amir's patches had added a similar change in the VFS layer...

BTW, Steve, do you intend to pull Darrick's copy-file-range-fixes
branch for 5.3 and add the extra cifs "file_modified" patch?

Thanks,
Amir.
