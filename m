Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40F7682E7D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 14:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjAaNxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 08:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjAaNxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:53:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FECB4B1A9;
        Tue, 31 Jan 2023 05:53:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06AB9B81CD7;
        Tue, 31 Jan 2023 13:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D347DC433EF;
        Tue, 31 Jan 2023 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675173231;
        bh=bvLwPR92JpXnBjgG6bBxJxMfSyvTaRAmgE72tGGpP/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azO8352mHIOQs2lAS69/ZHD9093eXf1qqiqTQRJyMWCrBJrshHwpGk5ECOw9QnXdi
         WCBgnj5vwpXfohQvoEGS6tG8AGL+9pbNcgPMHUZIovbeyf9CwwmdBxGcsuuHR1+tP5
         68jQi1wlgMUvA0taQBSyZG5OI+zaaDyTLnIGNIudVZPzdWuFDkkXSxhC4U3fEtHQDH
         jhxvHeiSqU9bLUc9IYgB+k34vEkddmxcxUz8YY3zhx4GWugUA971DODiO6NWCoxKY/
         FuXG4/S/mAAyaARWL4tyr0IfuckVRLY6svIrqYWkBvi2OGeN1OHqPFLT3lHQrDO125
         rPkwKElqK738A==
Date:   Tue, 31 Jan 2023 14:53:46 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Val Cowan <vcowan@redhat.com>
Subject: Re: [RFC PATCH v1 0/6] proc: Add allowlist for procfs files
Message-ID: <Y9kdaty9lP2gu510@example.org>
References: <cover.1674660533.git.legion@kernel.org>
 <20230125153628.43c12cbe05423fef7d44f0dd@linux-foundation.org>
 <20230126101607.b4de35te7gcf6mkn@wittgenstein>
 <Y9KCkuGqyr5T13XN@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9KCkuGqyr5T13XN@example.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:39:30PM +0100, Alexey Gladkov wrote:
> > In general, such flexibility belongs into userspace imho.
> > 
> > Frankly, if that is really required it would almost make more sense to
> > be able to attach a new bpf program type to procfs that would allow to
> > filter procfs entries. Then the filter could be done purely in
> > userspace. If signed bpf lands one could then even ship signed programs
> > that are attachable by userns root.
> 
> I'll ask the podman developers how much more comfortable they would be
> using bpf to control file visibility in procfs. thanks for the idea.

I write for history.

After digging into eBPF, I came to the conclusion that nothing needs to be
done in kernel space. Access can be controlled via "lsm/file_open". Access
can be controlled per cgroup or per mountpoint, depending on the task.
Each project has its own choice.

Many thanks for pointing out eBPF.

-- 
Rgrds, legion

