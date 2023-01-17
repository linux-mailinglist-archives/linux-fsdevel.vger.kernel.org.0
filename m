Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D726670C1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 23:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjAQWuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 17:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjAQWtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:49:24 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294A75955A
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 14:31:28 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so369932pjl.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jan 2023 14:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqJXYBDmrbeooCmHDsMGFLU6mELdGFs2m6PX0do2Leo=;
        b=XSp9mNuzfeV7YL2+QebLgQgfbenDRmm31Be5wzz++x7Y9GR0l395ibEpFvTuka9qAK
         RKEKLNyS3GB+EMK//o6CEsI98iveWI4RKA3TYakp0HNODLt4DXJHuZTEaItPEYXSy1Zg
         ozc+k4FMMnvEh3fqBD6dmD5vw2fTcA1HQ/OjcnVwkb7y1nd1m66DU+pXr6XXImNWTVaz
         PrVhvcORW/KYpAxFcuOwOX55W5Rs4u1jyF5X+hiC6ORAX6NP+T7IFjYy8d6+Ii9ONv5/
         vzbg+dLn5XjnVC35br5TKe8cD8TESDxA1x+mIJi0d7E7QsKvpH+tsSikIVCPZSRZfjaw
         v6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqJXYBDmrbeooCmHDsMGFLU6mELdGFs2m6PX0do2Leo=;
        b=TPF97kC71CcdPwfJtFwmawgqGqTxNy9JOUkhWcs4aV9noB9hIgu8TLfFQnl04nxWt+
         +tg4NUdz1Mv94mTbyRE0dUmnX6N+bRsY7askF51lFCIQTLQ1231QQx8UAS/Y0g3Be0Ot
         9cmMAHCRY7n62rRo4re2CErJktdLo8b4Lvjanooik6tRyrvc86JL4i6pOlqpIIiSyy0h
         FbBOmXORoAyCc4gMW0RJ2pGOUPRFg5AhXKPlNMshalu+FEac3B/90VPT/V1csDmjQp8T
         fHUxJr2GalEW4pQ+BkAtcFX/lxnEsX4MQpOicpEC+/5vQcUWHmxvhRyaAXpiscrrOyrS
         gJtg==
X-Gm-Message-State: AFqh2koWoObva/ZezKOSlvI+UgtBFsy3wGxHakF8q+t0xiccD1QkpRzM
        AobJLgPsl+UMnD67sOf64XhsCUU18D03vmV0
X-Google-Smtp-Source: AMrXdXv5Dr3iUyBLNo5LWjnUOYzDLJGJ6ceeYn1SGwwWblFxt933HUOe+nLrDb2GtQVMWS/Sx58wiQ==
X-Received: by 2002:a17:90b:4fcf:b0:229:869e:c916 with SMTP id qa15-20020a17090b4fcf00b00229869ec916mr4777396pjb.3.1673994687638;
        Tue, 17 Jan 2023 14:31:27 -0800 (PST)
Received: from dread.disaster.area (pa49-186-146-207.pa.vic.optusnet.com.au. [49.186.146.207])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a16c200b002272616d3e1sm40321pje.40.2023.01.17.14.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:31:27 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pHuUF-004JqG-BQ; Wed, 18 Jan 2023 09:31:23 +1100
Date:   Wed, 18 Jan 2023 09:31:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 00/25] fs: finish conversion to mnt_idmap
Message-ID: <20230117223123.GA937597@dread.disaster.area>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 12:49:09PM +0100, Christian Brauner wrote:
> Hey everyone,
> 
> Last cycle we introduced struct mnt_idmap in
> 256c8aed2b42 ("fs: introduce dedicated idmap type for mounts")
> and converted the posix acl high-level helpers over in
> 5a6f52d20ce3 ("acl: conver higher-level helpers to rely on mnt_idmap").
> 
> This series converts all places that currently still pass around a plain
> namespace attached to a mount to passing around a separate type eliminating
> all bugs that can arise from conflating filesystem and mount idmappings.
> After this series nothing will have changed semantically.
> 
> Currently, functions that map filesystem wide {g,u}ids into a mount
> specific idmapping take two namespace pointers, the pointer to the mount
> idmapping and the pointer to the filesystem idmapping. As they are of the
> same type it is easy to accidently pass a mount idmapping as a filesystem
> idmapping and vica versa. In addition, as the mount idmapping is of the
> same type as the filesystem idmapping, it can be passed to all {g,u}id
> translation functions. This is a source of bugs. We fixed a few such bugs
> already and in fact this series starts with a similar bugfix.
> 
> With the introduction of struct mnt_idmap last cycle we can now eliminate
> all these bugs. Instead of two namespace arguments all functions that map
> filesystem wide {g,u}ids into mount specific idmappings now take a struct
> mnt_idmap and a filesystem namespace argument. This lets the compiler catch
> any error where a mount idmapping is conflated with a filesystem idmapping.
> 
> Similarly, since all functions that generate filesystem wide k{g,u}id_ts
> only accept a namespace as an argument it is impossible to pass a mount
> idmapping to them eliminating the possibility of accidently generating
> nonsense {g,u}ids.
> 
> At the end of this conversion struct mnt_idmap becomes opaque to nearly all
> of the vfs and to all filesystems. It's moved into separate file and this file
> is the only place where it is accessed. In addition to type safety, easier
> maintenance, and easier handling and development for filesystem developers it
> also makes it possible to extend idmappings in the future such that we can
> allow userspace to set up idmapping without having to go through the detour of
> using namespaces at all.
> 
> Note, that this is an additional improvement on top of the introduction of
> the vfs{g,u}id_t conversion we did in earlier cycles which already makes it
> impossible to conflate filesystem wide k{g,u}id_t with mount specific
> vfs{g,u}id_t.
> 
> The series is available in the Git repository at:
> 
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.mnt_idmap.conversion.v1
> 
> Fstests, selftests, and LTP pass without regressions.

All the XFS modifications in the series look OK. So for them:

Acked-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
