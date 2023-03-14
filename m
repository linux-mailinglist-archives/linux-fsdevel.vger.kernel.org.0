Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311346B8AD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 06:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCNFvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 01:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCNFvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 01:51:08 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A370518B2D;
        Mon, 13 Mar 2023 22:51:07 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id u16so2456378vso.1;
        Mon, 13 Mar 2023 22:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678773066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkELbpHMWnIvY0KDDq1ZWS8/EaM606iOo5TghU491kA=;
        b=T+/T5q8DzR6UXJGAt4lEVfGCadU4yGdX0Z+bGRL2FhlE9GuZsqhFVfzKjbmDaTlkvN
         +OTX6HHRauuX/ELDDUbCDcFQ3tEB8g10igLEmU+2CqqbCVnAgo8o3dCRfciyW9nrIUWH
         mKvRiBV1dTLzsJqqEfCN3mvdoGOm+ObzBTXKAxHHRs9k9NABvUbpnXkPtujfm9oUfzH7
         SqDvHcStHwey4msWaZF8KBeo/NmTdNpb2yVjF6IjOxPACtenGqOHCqEbHR7+1sdrix/F
         bFJClpaF8okpBnkRtc/TGBVCXAxNWNG/lcfFosbd8r7dBa0q5nk3xrjvA3cqsHWP1uO3
         MQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678773066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkELbpHMWnIvY0KDDq1ZWS8/EaM606iOo5TghU491kA=;
        b=a0cvHTUk4SwnfBe2Z35EhhmOpBwTKyCRGSe6FJOJ6IenD8mozLWSDj+Phhck+ep0cj
         sc5NIp6fj6qWz93RngcirdxK0idUCOBF7WSnYEziUHBiC+dun8XtoA25CspNTJwZycWm
         4txIa8CNWgZTsaU5NP1iBV3Di2Fwu4fNeGTTASyISRUjatpkgTzRiuwU4wPiIirc2yR1
         UQQ+hDg7Px0pKRtjJGure1TN6/P6MsP5tCTlFHKg+p0nTQlDfj9drBxDqNXBqSnN0iIO
         vBo6ElXqjZmlDX8WGVFn6v/s7jbvnUvI1Hty2N8P1Lsn/qCxJ13s9DAECPH47W+W/Azb
         45Gg==
X-Gm-Message-State: AO0yUKWWC9JjPMxogkUFAfMZz+uWESsfJrRVtlVM1S1n73e8UzHe5rup
        uVaBREr9Z2bSi5vH0uGJyBRgi+TZ0Zl4SxKZEcRayIp0Kx4=
X-Google-Smtp-Source: AK7set/ZX6QQLTH3WtDU4dZhg+6KVBiIQpyrel5QVbBkzj+MkkvxnGOUDVBVgn11yKGk9ecRtuuCL++W816mNECa2D8=
X-Received: by 2002:a05:6102:10c:b0:425:aec3:694 with SMTP id
 z12-20020a056102010c00b00425aec30694mr171131vsq.0.1678773066424; Mon, 13 Mar
 2023 22:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230314042109.82161-1-catherine.hoang@oracle.com> <20230314042109.82161-4-catherine.hoang@oracle.com>
In-Reply-To: <20230314042109.82161-4-catherine.hoang@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 14 Mar 2023 07:50:55 +0200
Message-ID: <CAOQ4uxiYVpF9gjt-kTVpnoVYboOFG-Fpfw=KMrM=-aEHod4vXw@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] xfs: add XFS_IOC_SETFSUUID ioctl
To:     Catherine Hoang <catherine.hoang@oracle.com>
Cc:     linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 6:27=E2=80=AFAM Catherine Hoang
<catherine.hoang@oracle.com> wrote:
>
> Add a new ioctl to set the uuid of a mounted filesystem.
>
> Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_fs.h |   1 +
>  fs/xfs/xfs_ioctl.c     | 107 +++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_log.c       |  19 ++++++++
>  fs/xfs/xfs_log.h       |   2 +
>  4 files changed, 129 insertions(+)
>
> diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
> index 1cfd5bc6520a..a350966cce99 100644
> --- a/fs/xfs/libxfs/xfs_fs.h
> +++ b/fs/xfs/libxfs/xfs_fs.h
> @@ -831,6 +831,7 @@ struct xfs_scrub_metadata {
>  #define XFS_IOC_FSGEOMETRY          _IOR ('X', 126, struct xfs_fsop_geom=
)
>  #define XFS_IOC_BULKSTAT            _IOR ('X', 127, struct xfs_bulkstat_=
req)
>  #define XFS_IOC_INUMBERS            _IOR ('X', 128, struct xfs_inumbers_=
req)
> +#define XFS_IOC_SETFSUUID           _IOR ('X', 129, uuid_t)

Should be _IOW.

Would you consider defining that as FS_IOC_SETFSUUID in fs.h,
so that other fs could implement it later on, instead of hoisting it later?

It would be easy to add support for FS_IOC_SETFSUUID to ext4
by generalizing ext4_ioctl_setuuid().

Alternatively, we could hoist EXT4_IOC_SETFSUUID and struct fsuuid
to fs.h and use that ioctl also for xfs.

Using an extensible struct with flags for that ioctl may turn out to be use=
ful,
for example, to verify that the new uuid is unique, despite the fact
that xfs was
mounted with -onouuid (useful IMO) or to explicitly request a restore of ol=
d
uuid that would fail if new_uuid !=3D meta uuid.

Thanks,
Amir.
