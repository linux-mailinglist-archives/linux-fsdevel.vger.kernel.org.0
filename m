Return-Path: <linux-fsdevel+bounces-57904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D5AB269A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA68C7BEAEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231BA1E47C5;
	Thu, 14 Aug 2025 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Buec2Wg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00BA12C544;
	Thu, 14 Aug 2025 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182352; cv=none; b=kagT63+rta1tLNE3ZTTivOmk729Aog2FazsnByZixCQlADR28gcokAUJeVKswEdAWfKL52HB7yHZofYhye8MJBgbWE8z8Ej9lIzIoOCd2Q+2VzneMtoYuLXUDG+SRRT/7jfEXgL+kkGx7DQXO/1z1musAJ93O/TFW1gikpm69iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182352; c=relaxed/simple;
	bh=AnC/DqN/3+QD8sNj2gcFRZg+yXdHvLgwCqX9lbwEcDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGTCCyBnh603O9aTaolWo3yvOCJunmc9p7xQp6BeFmc8X6x3fG0kXru4WyXhZWtQQjsShEmhMCL6vzN4lMB+49QSTdUhoTy0ck9kt/3KzjJGC8VxCuQ8DDGPel5Brx/4JkDwAhDpRxtJeojFDrSJKUJDHw77WWOm2v5f1gll9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Buec2Wg9; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cceb83f85so572469fac.2;
        Thu, 14 Aug 2025 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755182350; x=1755787150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWpyQA5QJOFGfrytZDcocu1YuU1IqW03ExZyqZsW3CI=;
        b=Buec2Wg9nOc0hQRuzk1DLLvboblH8PHCUiPDIeYI5TAPW3aRmESkzk00k8hMARKSsA
         XXy8gkf8V0SvZH5BvBGYZQgizn6xewzzifAK7Gub4JZQgSQ4TChGNIVGSuojvFxei+A/
         JJlDXbv+5RWnGSyAM1+S+RjTgAo2pLh2htBWaWkXNwBKftDZYdcKhxm6Gx0tFS1ifmEl
         i77aU2/3h2yol9dzcxv4mG9Kf6ouX0/0tKlNFsgNwFr8Rs9IfHMqWIANQA4sg7SEjASW
         xCFd9VPzPqyzzwhLl3X01eTeXgIogvi0m01tFNe59dIsWvTMZXyUblrgAYtzf0MhKFdh
         MOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755182350; x=1755787150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWpyQA5QJOFGfrytZDcocu1YuU1IqW03ExZyqZsW3CI=;
        b=SO3lsiRl05J2lrhdkDHaujazQah83ViekWKKSBPUxzZNzgIMed5zjp0ECESEKDDX9A
         fsgf4onl5hRCucu5GL/fJsRQBwempM/n9CV/cdhjveig+GyUot0HpJGakBjawahya1jT
         RkdAOQCviW/iRYGRQh3K9TPMcqjuVthO7ciKcz9h93ZQlNgn58wnT/BedEQhaOHKrfDP
         yR7pYEl5EWr4FjYqSsR4h03mlVF802Pd5ccQZ6A1hwL2Oliox+okNvz4luoNcZWVYUmy
         +zBy/lHGQLhaYM6KjAHvAVVn/OIHrzUOPnFY54MnmyV1YnIQDbugtOYRfPv6YKUFrpjM
         OKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmFAkNH1CK2ijivgBODsGxyp6DZSpp0JnUSaxN8VOh8BHfnUhkwt6KPHT+Hsja1cLbU/Q6UdMBX40=@vger.kernel.org, AJvYcCVCmjBEgq0O0euEZJivOAW7HeCqTIUfczdbaMPHf5Sj4XHWLBUH8tWQHEvp7A9tdhX+9/upTPX4dWfjS6GV@vger.kernel.org, AJvYcCVwKiWuyVRcz7oTH0ABaaKImF5oj579VxE4Re0lNxUKduGQkpdxvCX8YVxK6lwxtgB0szKErOlL7Nw9@vger.kernel.org, AJvYcCW7x/xU5Nh5UsXiHUc6ujSzMWS1jQidvgKgvaDcdONgYeAK8z2kPDtAnqS+XOPwHdKZTim7LuHNtLNcBCa1Og==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJDtfBJNIweXZm71UJ4DD/MKPNghfzD14DwcymzP4ERHWFrG0
	51D9E5NF26VawKpFgDO9LRVd808g3Wj7qukf+VdZtMG8FOcvjSj8R8k6
X-Gm-Gg: ASbGncuGgGQ1RRce2p9xoM2TMzyTXPuXrJzSRgXQagoEaf2pOmKmfp9E8Q6Lb65aoPT
	zTJZhPl8GL5k+UjWl6Oiuy1q/Bgk0be87+1yC0Ocv+RUlb0aMO2IWox/ToUb+V5tPcWYYVVsO1G
	ZLu7Vdyqom3xgjjOdzN4ubWRQIPP0d71O3u+5AavipIx57bngzaW/OK2Lkon6tmIDZbcVC9dpny
	hIpGQA6z2X6Ua7s6DqBCpSgqlRtDtKyrb+FGAp2GAvCnyzsJe3hFMmvHrAc3ZZrvoe3lf3A+XoN
	4VWVterR2PHeRu3YySj+B/+EBx3AwEcSm/zxxxPsuJ7haHWvyAjQRJcjifyOR5dyrON/IHvDvP1
	g93KjZnlrsW576OlwNgO4oJurZx6FnJiIlGA=
X-Google-Smtp-Source: AGHT+IG/0DykLtw0r1gxLmo0cOZgYGY+cYP6P2+OvSN7+o24BGSh9UPK1E6zyX60n1GNyXlKeGrCwA==
X-Received: by 2002:a05:6871:283:b0:30b:9a99:8d67 with SMTP id 586e51a60fabf-30cd12ea93dmr2086335fac.22.1755182349763;
        Thu, 14 Aug 2025 07:39:09 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:c402:c230:52f:252c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30ccfe57152sm687204fac.10.2025.08.14.07.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:39:09 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 14 Aug 2025 09:39:07 -0500
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 11/18] famfs_fuse: Basic famfs mount opts
Message-ID: <z56yzi6y4hbbvcwpqzysbmztdhgsuqavjbnhsjxp3iumzvvywv@ymudodg3mb5x>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-12-john@groves.net>
 <20250709035911.GE2672029@frogsfrogsfrogs>
 <ttjh3gqk3fmykwrb7dg6xaqhkpxk7g773fkvuzvbdlefimpseg@l5ermgxixeen>
 <20250712055405.GK2672029@frogsfrogsfrogs>
 <CAJfpegspQYVbWVztU5_XFwbGaTQKe2NCm2mcui6J3qv1VDxdSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegspQYVbWVztU5_XFwbGaTQKe2NCm2mcui6J3qv1VDxdSQ@mail.gmail.com>

On 25/08/14 12:37PM, Miklos Szeredi wrote:
> On Sat, 12 Jul 2025 at 07:54, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, Jul 11, 2025 at 10:28:20AM -0500, John Groves wrote:
> 
> > >     famfs_fuse: Basic famfs mount opt: -o shadow=<shadowpath>
> > >
> > >     The shadow path is a (usually tmpfs) file system area used by the famfs
> > >     user space to commuicate with the famfs fuse server. There is a minor
> > >     dilemma that the user space tools must be able to resolve from a mount
> > >     point path to a shadow path. The shadow path is exposed via /proc/mounts,
> > >     but otherwise not used by the kernel. User space gets the shadow path
> > >     from /proc/mounts...
> 
> Don't know if we want to go that way.  Is there no other way?
> 
> But if we do, at least do it in a generic way.  I.e. fuse server can
> tell the kernel to display options A, B and C in /proc/mounts.
> 
> Thanks,
> Miklos

So far I haven't come up with an alternative, other than bad ones. 

Could parse the shadow path from the fuse server with the correct mount
point from 'ps -ef', but there are cases where a fuse server is killed and 
the kernel still thinks it's mounted (and we still might need to find the 
shadow path).

Could write the shadow path to a systemd log and parse it from there, but 
that would break if the log wasn't enabled, and would disappear if the log
was rotated during a long-running mount - and this resolution must happen
every time the famfs cli does most anything (cp, creat, fsck, etc.).

Could write it to a "secret file" somewhere, but that's kinda brittle.

Shadow paths are almost always tmpdir paths that are generated at mount time,
so there really isn't a good way to guess them, and it doesn't seem viable
to require them to be in (e.g.) /tmp in all cases.

Here is what it currently looks like on a running system:

$ grep famfs /proc/mounts
/dev/dax0.0 /mnt/famfs fuse rw,nosuid,nodev,relatime,user_id=0,group_id=0,shadow=/tmp/famfs_shadow_5m0dnH 0 0
$ ps -ef | grep /mnt/famfs | grep -v grep
root       12775       1  0 07:04 ?        00:00:00 /dev/dax0.0 -o daxdev=/dev/dax0.0,shadow=/tmp/famfs_shadow_5m0dnH,fsname=/dev/dax0.0,timeout=31536000.000000 /mnt/famfs

Having a generic approach rather than a '-o' option would be fine with me.
Also happy to entertain other ideas...

Thanks,
John


