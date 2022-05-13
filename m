Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A20526CC9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 00:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384825AbiEMWJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 18:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384812AbiEMWJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 18:09:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CE364E7
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 15:09:44 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso11987853pjb.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 15:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mip6GB+UOxs40OE0wM8HSHN4JOWEcgh6ZJadFhE8R6M=;
        b=hG3F2MTWmspdKtHcKZJp220fMBZM5LR050BELG+dE11wxITHxXRC2n6V/hGuI8s7cw
         QQUImjQd8ydkGgqgaukb8rYw7e3mZMpVFGPbeXyQGY1/8AacuRbrw7a4IIJbkhjy9ABs
         RcyurlmuizIBp/nznhwbdGMyz1Bqfy2HL52+ZIR3nRRevvBxLNUS35/FRrYyN0s81m9u
         kpx1NbfR49gssH4i1uI9kJGSfPuCJZ9Tem2zirzgiuyF6NSu/PKBurU0pvg9yz0fgn+U
         r7r1IXiOoDuVmW26Q9XgEDFebIoZbKA+aFEsq5Fy/o0aEzpdXM3iMmJHCSL3LZ0S/l47
         HxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mip6GB+UOxs40OE0wM8HSHN4JOWEcgh6ZJadFhE8R6M=;
        b=HUtn24Zoizw5FPQWEDXQFn+Yx4a050aftCH4hJ2yueqMQE2Ynew3HRWYrKxz/o8kyL
         /0Zn+XCufiAXLVAwhINRzybMr+6xpSX0jD+CJ52W7xJTnL4Jv9hPf/I1HBdgJAI5x95G
         7fZ8Kg3WZTuov0ZHq3begUPTqeIZGinzHwxstKMrlPXKW+ufA3r4j1Jwq5gUPB5i3zFc
         6o+Be+wolttLboPmtR5/QMN8WYOW/ojwGNFzFe/04uweOAVc6BoAAHKX8ntC6WI6ySNj
         HUVos8Kh0oAsWAigyDz/AxYpExQERnwpzUobKo/OIJNz/8rBMtnvg4z3nzmWocNyYcTj
         wg4w==
X-Gm-Message-State: AOAM5329XK1LyqJOfE85W4AE57Bjfo0ZJg/Dt9iN9BetPq3P+fx91p9f
        O919vtbucbc2/xOlHrQGrYLJQ9KEm+khXtQjA9sf6g==
X-Google-Smtp-Source: ABdhPJzpfY8MlgI5f++tvopz4LYKd5ilu/z06Js/hnaOsL1+374Mzjwb83UO8JaxESRupngEQCtjfZyPDj2zPFQAv3s=
X-Received: by 2002:a17:90b:3845:b0:1dc:a733:2ece with SMTP id
 nl5-20020a17090b384500b001dca7332ecemr6990831pjb.220.1652479783256; Fri, 13
 May 2022 15:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220422224508.440670-5-jane.chu@oracle.com> <165247892149.4131000.9240706498758561525.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <165247892149.4131000.9240706498758561525.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 13 May 2022 15:09:32 -0700
Message-ID: <CAPcyv4g8Tkx_b_Rs1WeAeV1knxV-z2r7Gmf56b8XN=CTyj6RVQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] dax: introduce DAX_RECOVERY_WRITE dax access mode
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jane Chu <jane.chu@oracle.com>, Christoph Hellwig <hch@lst.de>,
        Vivek Goyal <vgoyal@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 13, 2022 at 2:56 PM Dan Williams <dan.j.williams@intel.com> wro=
te:
>
> From: Jane Chu <jane.chu@oracle.com>
>
> Up till now, dax_direct_access() is used implicitly for normal
> access, but for the purpose of recovery write, dax range with
> poison is requested.  To make the interface clear, introduce
>         enum dax_access_mode {
>                 DAX_ACCESS,
>                 DAX_RECOVERY_WRITE,
>         }
> where DAX_ACCESS is used for normal dax access, and
> DAX_RECOVERY_WRITE is used for dax recovery write.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-=
dax.c
> index af19c85558e7..dcc328eba811 100644
> --- a/tools/testing/nvdimm/pmem-dax.c
> +++ b/tools/testing/nvdimm/pmem-dax.c
> @@ -8,7 +8,8 @@
>  #include <nd.h>
>
>  long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
> -               long nr_pages, void **kaddr, pfn_t *pfn)
> +               long nr_pages, enum dax_access_mode mode, void **kaddr,
> +               pfn_t *pfn)

Local build test reports:

tools/testing/nvdimm/pmem-dax.c:11:53: error: parameter 4 (=E2=80=98mode=E2=
=80=99) has
incomplete type
   11 |                 long nr_pages, enum dax_access_mode mode, void **ka=
ddr,
      |                                ~~~~~~~~~~~~~~~~~~~~~^~~~


...so need to include linux/dax.h in this file now for that definition.
