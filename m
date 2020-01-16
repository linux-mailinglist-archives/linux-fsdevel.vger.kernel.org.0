Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E791B13EE92
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 19:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393451AbgAPSJf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 13:09:35 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:44342 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388231AbgAPSJe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:09:34 -0500
Received: by mail-ot1-f48.google.com with SMTP id h9so20168410otj.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQb8Uq0IKx193QyLS3C+yGAjzOMy3a3CukknBRN2elo=;
        b=Z9dKYGG/It3ZDq626KVAn3UYMJ8w5rR7FNp1xgY+lJV2JdQ8DWHIetf1F8KloLda3X
         39gAmzG6xzkqr5D4Ak+0h08VxlZHpS0TnHAHHZwNZrxSD9H0o70ll3pjpzqbXTbh1DKL
         DNBT464rgyw5mNlpF54auwQ7W0YShGDSgsOZLiQe9UuUK/EI3rXInwadnnG1lGK7QCU1
         3w5gr6gsDviIi8iAJ4m/+JCGUJ3agwdBGY3e7V1tUCcAsasgKFwzh4MHrwHdLzXIgLAk
         x0PHbDzD2veOuVMZQjGO+cEu0iHunQLVEGPuaT782qMLmcgX5LnyP/rsd3PiYSGCcLoS
         c59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQb8Uq0IKx193QyLS3C+yGAjzOMy3a3CukknBRN2elo=;
        b=YlNqxPKsLmMCrEWK8RDHBI/VyHm12v8mV2AcGLtRf/L+CXecxHjAELz9QFbBJY2RDU
         xxQoadXWEa3jjgGVW/pLxjrAB7OFCcrnpi0zlPa1Jqgg1yEtnkQQodx6vrEBSjyaywam
         K3e7+b6efTaMULwvLOeI7vbf7kx1XlZ667J9ZQKe9AxdinH63BV/xzVuOaa+Tn8+idxY
         kBRX9zhyJX7NaAso5CkL4XKoxnuju5YSniTTaV0jk7ne9Lqd0n5pOGykHR219jcYjUE3
         FZv2JLx0TpgG3Y4fBPJEWykYy4/1g8aioVY98z55w0KK+M1LY9a+DkjsS1EavQSVXV4+
         +sqg==
X-Gm-Message-State: APjAAAX6QNaSOsBdFVzWvHq9HDdDzNEkzLxiC+6/EObULU8Ws/orfii9
        DLjPTThvtuzqfpffoQAHOD52TIRhYxqzPV2bb9+W4A==
X-Google-Smtp-Source: APXvYqyXr3lS+JZj9aYaGZcaZ677aNc3G5lICFsM5cpGfCF42dv3olbejurJoFC1AmwOnpAVRiOEEAY2CuZWxYa6P3Q=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr3079638otq.126.1579198173237;
 Thu, 16 Jan 2020 10:09:33 -0800 (PST)
MIME-Version: 1.0
References: <20200106181117.GA16248@redhat.com> <20200116145403.GB25291@redhat.com>
In-Reply-To: <20200116145403.GB25291@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 16 Jan 2020 10:09:22 -0800
Message-ID: <CAPcyv4hNQ3qtF1CA5Bb3NkSyUbw+_3CCY2e97EMXS4jfHTF7ag@mail.gmail.com>
Subject: Re: dax: Get rid of fs_dax_get_by_host() helper
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 16, 2020 at 6:54 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Jan 06, 2020 at 01:11:17PM -0500, Vivek Goyal wrote:
> > Looks like nobody is using fs_dax_get_by_host() except fs_dax_get_by_bdev()
> > and it can easily use dax_get_by_host() instead.
> >
> > IIUC, fs_dax_get_by_host() was only introduced so that one could compile
> > with CONFIG_FS_DAX=n and CONFIG_DAX=m. fs_dax_get_by_bdev() achieves
> > the same purpose and hence it looks like fs_dax_get_by_host() is not
> > needed anymore.
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>
> Hi Dan,
>
> Ping for this patch. How does it look to you. If you don't have concerns,
> can you please take it in your tree.

Yes, looks good and applied.
