Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175C0756C9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 20:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjGQS5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 14:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjGQS5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:57:39 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB0A6;
        Mon, 17 Jul 2023 11:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689620255; bh=QjarRr5INc1/uxBbtmYZtobDq1CXveXr5bGBIPDVF4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kPKqI1qnUradqvDXY/avvWONP/9Ze67ruR6b0ZwL4zShoT/uWQPCbz617dIp11tlL
         ea/fsf3n2wn4KmmU92EGRMF1wV/lDvKj8MTQkl5vb0Ffkme8Cr5OUNKHHfy5vRHm3/
         V28DJR3CIEs2WXGaHJBcABrzwjIbwelBUJ8cAeKE=
Date:   Mon, 17 Jul 2023 20:57:34 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org,
        jack@suse.cz, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: [PATCH v5 04/11] blksnap: header file of the module interface
Message-ID: <822909b0-abd6-4e85-b739-41f8efa6feff@t-8ch.de>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-5-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612135228.10702-5-sergei.shtepa@veeam.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-06-12 15:52:21+0200, Sergei Shtepa wrote:

> [..]

> diff --git a/include/uapi/linux/blksnap.h b/include/uapi/linux/blksnap.h
> new file mode 100644
> index 000000000000..2fe3f2a43bc5
> --- /dev/null
> +++ b/include/uapi/linux/blksnap.h
> @@ -0,0 +1,421 @@

> [..]

> +/**
> + * struct blksnap_snapshotinfo - Result for the command
> + *	&blkfilter_ctl_blksnap.blkfilter_ctl_blksnap_snapshotinfo.
> + *
> + * @error_code:
> + *	Zero if there were no errors while holding the snapshot.
> + *	The error code -ENOSPC means that while holding the snapshot, a snapshot
> + *	overflow situation has occurred. Other error codes mean other reasons
> + *	for failure.
> + *	The error code is reset when the device is added to a new snapshot.
> + * @image:
> + *	If the snapshot was taken, it stores the block device name of the
> + *	image, or empty string otherwise.
> + */
> +struct blksnap_snapshotinfo {
> +	__s32 error_code;
> +	__u8 image[IMAGE_DISK_NAME_LEN];

Nitpick:

Seems a bit weird to have a signed error code that is always negative.
Couldn't this be an unsigned number or directly return the error from
the ioctl() itself?

> +};
> +
> +/**
> + * DOC: Interface for managing snapshots
> + *
> + * Control commands that are transmitted through the blksnap module interface.
> + */
> +enum blksnap_ioctl {
> +	blksnap_ioctl_version,
> +	blksnap_ioctl_snapshot_create,
> +	blksnap_ioctl_snapshot_destroy,
> +	blksnap_ioctl_snapshot_append_storage,
> +	blksnap_ioctl_snapshot_take,
> +	blksnap_ioctl_snapshot_collect,
> +	blksnap_ioctl_snapshot_wait_event,
> +};
> +
> +/**
> + * struct blksnap_version - Module version.
> + *
> + * @major:
> + *	Version major part.
> + * @minor:
> + *	Version minor part.
> + * @revision:
> + *	Revision number.
> + * @build:
> + *	Build number. Should be zero.
> + */
> +struct blksnap_version {
> +	__u16 major;
> +	__u16 minor;
> +	__u16 revision;
> +	__u16 build;
> +};
> +
> +/**
> + * define IOCTL_BLKSNAP_VERSION - Get module version.
> + *
> + * The version may increase when the API changes. But linking the user space
> + * behavior to the version code does not seem to be a good idea.
> + * To ensure backward compatibility, API changes should be made by adding new
> + * ioctl without changing the behavior of existing ones. The version should be
> + * used for logs.
> + *
> + * Return: 0 if succeeded, negative errno otherwise.
> + */
> +#define IOCTL_BLKSNAP_VERSION							\
> +	_IOW(BLKSNAP, blksnap_ioctl_version, struct blksnap_version)

Shouldn't this be _IOR()?

  "_IOW means userland is writing and kernel is reading. _IOR
  means userland is reading and kernel is writing."

The other ioctl definitions seem to need a review, too.
