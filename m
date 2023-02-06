Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C782668BD52
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 13:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjBFMwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 07:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBFMwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:52:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A1555B8
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Feb 2023 04:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675687897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ifwcXjffS5iX3Wzgvhzj7ha2xRW0KwSRE7dQCFFOZsM=;
        b=AEyjBYNxiGZdJMkztAgxc2qIcyXqZA+SoFKhvk/B2w/k6cxDzPWcR4Dr+P7+ROVoCrWmDM
        8kzz3rZNvFi4KrSNaWRXpbsBwvLjX0mluZvD96PAulqO0KlAJZziRYSYzwCLYh4JtV3Mp6
        48cOEj0S6Z/DSVGvP7OdM0dmCVeBsts=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-392-tWOvHgr0NmKBiLdBteINMA-1; Mon, 06 Feb 2023 07:51:36 -0500
X-MC-Unique: tWOvHgr0NmKBiLdBteINMA-1
Received: by mail-il1-f199.google.com with SMTP id j25-20020a056e02219900b0031398da82efso5671168ila.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Feb 2023 04:51:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifwcXjffS5iX3Wzgvhzj7ha2xRW0KwSRE7dQCFFOZsM=;
        b=Nvz4rCsQM3q2EKix3iK9PLX6/MU6AnlQIJYMF1WmKRDtLMzU1Vfe9t6AveqcAGU+c3
         DwPF8v3k267QSXJB2rXSStZW/+s5vCv8TyRNplMdsGGZ9EktzO4JGHlJgIkT4sKJvz4l
         tJ9rlFmho6+gsPrPLQKNP0eJpiDNfOotgIA+LD/CXNukOF8KuTXCCFDCbSBF9g7HRQqA
         Cn77xIF+2vKpSzn6qL0GC1z/adUtYTMMltHcxwBnxVKV1wUNItL3UGk3D8ImPo+A7wdg
         6B7OfYY/Y8jJpqqNXrECwnHgO3kKCrFrPk0nA0SpcUiHjEK8FgeV60Iz+IMwy8irjlHL
         LvMg==
X-Gm-Message-State: AO0yUKVAG8gfhLYzpj8wxTUJbmi8LJuIJiHuGV6oS73q6AkzaXOB2Hbu
        p81P3sj1oxdbuTJm1ckWd1ZEOJepgfHtFGuWa+Fa+EWaGHLotI4hSsdhZboWfpeSNy7hQMI/8C9
        3iPI1VXUDJmYcGkn2Dy2q9wcnWiw6vcjG6b1ID4UBvA==
X-Received: by 2002:a92:2003:0:b0:30f:37f5:8520 with SMTP id j3-20020a922003000000b0030f37f58520mr4114739ile.63.1675687895459;
        Mon, 06 Feb 2023 04:51:35 -0800 (PST)
X-Google-Smtp-Source: AK7set9u3HxPCFqZR4p4eu29bUB1Xc/eCwyzixc3OaYR9kmU4mT7+cF5MnSKpHeWMeoI5eaWsTgM/mYe+uqceoMm4Uo=
X-Received: by 2002:a92:2003:0:b0:30f:37f5:8520 with SMTP id
 j3-20020a922003000000b0030f37f58520mr4114732ile.63.1675687895200; Mon, 06 Feb
 2023 04:51:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674227308.git.alexl@redhat.com> <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
 <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com> <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com> <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
 <071074ad149b189661681aada453995741f75039.camel@redhat.com>
 <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com> <de57aefc-30e8-470d-bf61-a1cca6514988@linux.alibaba.com>
 <CAOQ4uxgS+-MxydqgO8+NQfOs9N881bHNbov28uJYX9XpthPPiw@mail.gmail.com>
 <9c8e76a3-a60a-90a2-f726-46db39bc6558@linux.alibaba.com> <02edb5d6-a232-eed6-0338-26f9a63cfdb6@linux.alibaba.com>
 <3d4b17795413a696b373553147935bf1560bb8c0.camel@redhat.com>
 <CAOQ4uxjNmM81mgKOBJeScnmeR9+jG_aWvDWxAx7w_dGh0XHg3Q@mail.gmail.com>
 <5fbca304-369d-aeb8-bc60-fdb333ca7a44@linux.alibaba.com> <CAOQ4uximQZ_DL1atbrCg0bQ8GN8JfrEartxDSP+GB_hFvYQOhg@mail.gmail.com>
In-Reply-To: <CAOQ4uximQZ_DL1atbrCg0bQ8GN8JfrEartxDSP+GB_hFvYQOhg@mail.gmail.com>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Mon, 6 Feb 2023 13:51:23 +0100
Message-ID: <CAL7ro1ETbWte1dsLY0kFsKdbw5POAahx55Hsk2nNvgGXAWE-CQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 5, 2023 at 8:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > >>> Apart from that, I still fail to get some thoughts (apart from
> > >>> unprivileged
> > >>> mounts) how EROFS + overlayfs combination fails on automative real
> > >>> workloads
> > >>> aside from "ls -lR" (readdir + stat).
> > >>>
> > >>> And eventually we still need overlayfs for most use cases to do
> > >>> writable
> > >>> stuffs, anyway, it needs some words to describe why such < 1s
> > >>> difference is
> > >>> very very important to the real workload as you already mentioned
> > >>> before.
> > >>>
> > >>> And with overlayfs lazy lookup, I think it can be close to ~100ms or
> > >>> better.
> > >>>
> > >>
> > >> If we had an overlay.fs-verity xattr, then I think there are no
> > >> individual features lacking for it to work for the automotive usecase
> > >> I'm working on. Nor for the OCI container usecase. However, the
> > >> possibility of doing something doesn't mean it is the better technical
> > >> solution.
> > >>
> > >> The container usecase is very important in real world Linux use today,
> > >> and as such it makes sense to have a technically excellent solution for
> > >> it, not just a workable solution. Obviously we all have different
> > >> viewpoints of what that is, but these are the reasons why I think a
> > >> composefs solution is better:
> > >>
> > >> * It is faster than all other approaches for the one thing it actually
> > >> needs to do (lookup and readdir performance). Other kinds of
> > >> performance (file i/o speed, etc) is up to the backing filesystem
> > >> anyway.
> > >>
> > >> Even if there are possible approaches to make overlayfs perform better
> > >> here (the "lazy lookup" idea) it will not reach the performance of
> > >> composefs, while further complicating the overlayfs codebase. (btw, did
> > >> someone ask Miklos what he thinks of that idea?)
> > >>
> > >
> > > Well, Miklos was CCed (now in TO:)
> > > I did ask him specifically about relaxing -ouserxarr,metacopy,redirect:
> > > https://lore.kernel.org/linux-unionfs/20230126082228.rweg75ztaexykejv@wittgenstein/T/#mc375df4c74c0d41aa1a2251c97509c6522487f96
> > > but no response on that yet.
> > >
> > > TBH, in the end, Miklos really is the one who is going to have the most
> > > weight on the outcome.
> > >
> > > If Miklos is interested in adding this functionality to overlayfs, you are going
> > > to have a VERY hard sell, trying to merge composefs as an independent
> > > expert filesystem. The community simply does not approve of this sort of
> > > fragmentation unless there is a very good reason to do that.
> > >
> > >> For the automotive usecase we have strict cold-boot time requirements
> > >> that make cold-cache performance very important to us. Of course, there
> > >> is no simple time requirements for the specific case of listing files
> > >> in an image, but any improvement in cold-cache performance for both the
> > >> ostree rootfs and the containers started during boot will be worth its
> > >> weight in gold trying to reach these hard KPIs.
> > >>
> > >> * It uses less memory, as we don't need the extra inodes that comes
> > >> with the overlayfs mount. (See profiling data in giuseppes mail[1]).
> > >
> > > Understood, but we will need profiling data with the optimized ovl
> > > (or with the single blob hack) to compare the relevant alternatives.
> >
> > My little request again, could you help benchmark on your real workload
> > rather than "ls -lR" stuff?  If your hard KPI is really what as you
> > said, why not just benchmark the real workload now and write a detailed
> > analysis to everyone to explain it's a _must_ that we should upstream
> > a new stacked fs for this?
> >
>
> I agree that benchmarking the actual KPI (boot time) will have
> a much stronger impact and help to build a much stronger case
> for composefs if you can prove that the boot time difference really matters.

I will not be able to produce any full comparisons of a car booting
with this. First of all its customer internal data, and secondly its
not something that is currently at a stage that is finished enough to
do such a benchmark. For this discussion, consider it more a weak
example of why cold-cache performance is important in many cases.

> In order to test boot time on fair grounds, I prepared for you a POC
> branch with overlayfs lazy lookup:
> https://github.com/amir73il/linux/commits/ovl-lazy-lowerdata

Cool. I'll play around with this. Does this need to be an opt-in
option in the final version? It feels like this could be useful to
improve performance in general for overlayfs, for example when
metacopy is used in container layers.

> It is very lightly tested, but should be sufficient for the benchmark.
> Note that:
> 1. You need to opt-in with redirect_dir=lazyfollow,metacopy=on
> 2. The lazyfollow POC only works with read-only overlay that
>     has two lower dirs (1 metadata layer and one data blobs layer)
> 3. The data layer must be a local blockdev fs (i.e. not a network fs)
> 4. Only absolute path redirects are lazy (e.g. "/objects/cc/3da...")
>
> These limitations could be easily lifted with a bit more work.
> If any of those limitations stand in your way for running the benchmark
> let me know and I'll see what I can do.
>
> If there is any issue with the POC branch, please let me know.
>
> Thanks,
> Amir.
>


-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

