Return-Path: <linux-fsdevel+bounces-66684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F707C28C6F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 10:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61FD84E34B8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74A265629;
	Sun,  2 Nov 2025 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoE60AOg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E502523D290
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Nov 2025 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762074535; cv=none; b=qGgwanB5dNVTXGzlfDlUcTY7ChnH9zNZZ4BWi0YVJbuO3LhJYZge7F/3DLlVx1odB/ZXVIPsTlRQlGaDCyEkB+EAOrGXtl/Hdcj4LIS3ntoo19gwzohpTE298wLMMY/VEMNa0mHXsDY9PB9I6Q4Qftx5Gc6Ca1BxvlPddjAG/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762074535; c=relaxed/simple;
	bh=7/D/9JuKlda0IizNfN3bJ+LCT/7NPYyYMDu6mmOz2tY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YfxWyW/hMP+FVrPyr2VOyjjhBNmW8iiNDt/zeoGeKgkMXirFq/wXgwyp2PHXPivguYY8bngreCTX0u+L8pBuPGQtxhE7QwttmatrekRxa/pNzziOEKeu3AqtTh+cCcBtZZ4WJw3z4goCPOpruBjXkle2KEBfbcjm/G1oxJx6ZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BoE60AOg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-471191ac79dso39234845e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Nov 2025 01:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762074531; x=1762679331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gICqRIRyRxEMMN/HX8MILNkO7MD4631S+ctChFJDT7Q=;
        b=BoE60AOgCemcRAQeAga9H1VyN+IdSueMy42Yy/0t/iKbz/FXyro8kJKxzXTA0edxtr
         kbIWqZgDH4Jz6QrKyarhvQwl2mAw8PfQlNMZY4P7mjNKIKmyw8xB3XijG/q5uXHgS1B0
         tcbGRKvlMfrW4tm4GlzbPugiTTn09a3xBmURBh0NKLGFXtnrN6xU+uzeNstBJYx+KE4Q
         o5Bhbi2MxGyqN8bxYAQq6kgqbxrtz6K9j3qNp9YPSXndHgy+gkMv8KHNIcQqzKeAgZv0
         jlCRcLdPR5SxBQTxRDbfRMNNo1WeaQLKcyQGK9uTMe7n/zUlppeasRkJyIkHMGfhIhzT
         WrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762074531; x=1762679331;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gICqRIRyRxEMMN/HX8MILNkO7MD4631S+ctChFJDT7Q=;
        b=v0BQfoSg8bKLUdokLzXYRVDKQDhvZptLqjMGsxRvzBM/JLAs+JAkMNvCXNu36OsYT+
         +uBvnHUkifhfm57vonTCtqhtRpIYV0V8oKQcw/IiiZaAOyPZ3hrriPQWKYpWH9PqBoh4
         iYLS7p9rWaRIqsZlwv+ptHFaCpXZPJAKqYOZCeWPihXgGucLeV35PGFlnlcW42Az0H8G
         OAHIGsoQKx8qQnbr5FCsDbKb5/uMToXv9e9dMwcava8ILH1z0ciUygqZnY4o2lyrUXJe
         YmLFqE08RbYtzl/B01cIoYVIi5UzbxedZxWLaWUODRQOrVmSt3Tbwsl9OSRBLX9cYeYC
         UdVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSAJwYME9EH6NaWfBfFsOym1T35agJ32IJDSdsZNpoW9Qme0Gv6Imn5VDxeuI3ckc7CkO4GASb3t0oUlNS@vger.kernel.org
X-Gm-Message-State: AOJu0YytsrDrjcwZp1sLPBombTjgNGhN+qIUyVYsg+tkgP0Ui1RL7dIJ
	yYqNqDYBZHGnI6oSOfTLyyRBf4InUjeEwHP32U3YxSMzlUdG9UpKwnKrwA51sON2vhA=
X-Gm-Gg: ASbGncueG5qvYN5INC/N3wnhTpcziqLsvAg0MBHIscAGGooutJA1ElEIwqccHgVgvSY
	sON/1+a0MFPjFraFtBVVM5gMmyV0doTIk3tij4EJsEXvluXPQ/JYcOB6ejVdlL8lb1a9f9jo233
	DWY0RCedrcmyVLw5W34/Ayw47QI78gXXbM5F6om9tJuQr2jUx4JOgnetXPiKmj/mECh+z17JXAa
	8Q09ITTlX0yA3Z1LI7qZ3FWjq+j7vQKck4L7x48fSu6nK4JfklscdoziamhMjb/lfLyW9K1y1uT
	0TwmYQK6hINptrLo0ovcFnMfi8lV5GeqwadtCXn2s5geWCILcCebPWuy+xRrUS8gAn2T2pWIVp8
	TZXp6WAo2SvQgnNCPs2H0XT0I3w41grLS4cApmt+JcM2iFmI0e8QlMgpPSYG8IuzDfe3msgoaMS
	sICJANpXNmMLs1eYII
X-Google-Smtp-Source: AGHT+IGn5bPwV56bsV2deYi9JT5okvhROQmNRKf5EUkUmao9tiHAn5dobVx2xgvTKyZJ700Wv08Crg==
X-Received: by 2002:a05:600c:6218:b0:475:dd53:6c06 with SMTP id 5b1f17b1804b1-477308ec45dmr82695135e9.40.1762074531098;
        Sun, 02 Nov 2025 01:08:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c114be36sm13128018f8f.18.2025.11.02.01.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:08:50 -0800 (PST)
Date: Sun, 2 Nov 2025 12:08:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, NeilBrown <neilb@ownmail.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chris Mason <chris.mason@fusionio.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v4 04/14] VFS/nfsd/cachefiles/ovl: add start_creating()
 and end_creating()
Message-ID: <202511021406.Tv3dcpn5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029234353.1321957-5-neilb@ownmail.net>

Hi NeilBrown,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/debugfs-rename-end_creating-to-debugfs_end_creating/20251030-075146
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20251029234353.1321957-5-neilb%40ownmail.net
patch subject: [PATCH v4 04/14] VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()
config: x86_64-randconfig-161-20251101 (https://download.01.org/0day-ci/archive/20251102/202511021406.Tv3dcpn5-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202511021406.Tv3dcpn5-lkp@intel.com/

smatch warnings:
fs/overlayfs/dir.c:130 ovl_whiteout() error: uninitialized symbol 'whiteout'.
fs/overlayfs/dir.c:130 ovl_whiteout() warn: passing zero to 'PTR_ERR'

vim +/whiteout +130 fs/overlayfs/dir.c

c21c839b8448dd Chengguang Xu     2020-04-24   97  static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
e9be9d5e76e348 Miklos Szeredi    2014-10-24   98  {
e9be9d5e76e348 Miklos Szeredi    2014-10-24   99  	int err;
807b78b0fffc23 NeilBrown         2025-10-30  100  	struct dentry *whiteout, *link;
c21c839b8448dd Chengguang Xu     2020-04-24  101  	struct dentry *workdir = ofs->workdir;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  102  	struct inode *wdir = workdir->d_inode;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  103  
8afa0a73671389 NeilBrown         2025-07-16  104  	guard(mutex)(&ofs->whiteout_lock);
8afa0a73671389 NeilBrown         2025-07-16  105  
c21c839b8448dd Chengguang Xu     2020-04-24  106  	if (!ofs->whiteout) {
807b78b0fffc23 NeilBrown         2025-10-30  107  		whiteout = ovl_start_creating_temp(ofs, workdir);
8afa0a73671389 NeilBrown         2025-07-16  108  		if (IS_ERR(whiteout))
8afa0a73671389 NeilBrown         2025-07-16  109  			return whiteout;

white out is not an error pointer.

807b78b0fffc23 NeilBrown         2025-10-30  110  		err = ovl_do_whiteout(ofs, wdir, whiteout);
807b78b0fffc23 NeilBrown         2025-10-30  111  		if (!err)
807b78b0fffc23 NeilBrown         2025-10-30  112  			ofs->whiteout = dget(whiteout);
807b78b0fffc23 NeilBrown         2025-10-30  113  		end_creating(whiteout, workdir);
807b78b0fffc23 NeilBrown         2025-10-30  114  		if (err)
807b78b0fffc23 NeilBrown         2025-10-30  115  			return ERR_PTR(err);
e9be9d5e76e348 Miklos Szeredi    2014-10-24  116  	}

whiteout not set on else path

e9be9d5e76e348 Miklos Szeredi    2014-10-24  117  
e4599d4b1aeff0 Amir Goldstein    2023-06-17  118  	if (!ofs->no_shared_whiteout) {
807b78b0fffc23 NeilBrown         2025-10-30  119  		link = ovl_start_creating_temp(ofs, workdir);
807b78b0fffc23 NeilBrown         2025-10-30  120  		if (IS_ERR(link))
807b78b0fffc23 NeilBrown         2025-10-30  121  			return link;
807b78b0fffc23 NeilBrown         2025-10-30  122  		err = ovl_do_link(ofs, ofs->whiteout, wdir, link);
807b78b0fffc23 NeilBrown         2025-10-30  123  		if (!err)
807b78b0fffc23 NeilBrown         2025-10-30  124  			whiteout = dget(link);

It's set here, but then returned on line 127.

807b78b0fffc23 NeilBrown         2025-10-30  125  		end_creating(link, workdir);
807b78b0fffc23 NeilBrown         2025-10-30  126  		if (!err)
807b78b0fffc23 NeilBrown         2025-10-30  127  			return whiteout;;

nit: double ;;

807b78b0fffc23 NeilBrown         2025-10-30  128  
807b78b0fffc23 NeilBrown         2025-10-30  129  		if (err != -EMLINK) {
672820a070ea5e Antonio Quartulli 2025-07-21 @130  			pr_warn("Failed to link whiteout - disabling whiteout inode sharing(nlink=%u, err=%lu)\n",
672820a070ea5e Antonio Quartulli 2025-07-21  131  				ofs->whiteout->d_inode->i_nlink,
672820a070ea5e Antonio Quartulli 2025-07-21  132  				PTR_ERR(whiteout));

whiteout is either valid or uninitialized.  For some reason
Smatch thinks whiteout can be NULL, I suspect because of
the NULL check in dget().

e4599d4b1aeff0 Amir Goldstein    2023-06-17  133  			ofs->no_shared_whiteout = true;
c21c839b8448dd Chengguang Xu     2020-04-24  134  		}
c21c839b8448dd Chengguang Xu     2020-04-24  135  	}
c21c839b8448dd Chengguang Xu     2020-04-24  136  	whiteout = ofs->whiteout;
c21c839b8448dd Chengguang Xu     2020-04-24  137  	ofs->whiteout = NULL;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  138  	return whiteout;
e9be9d5e76e348 Miklos Szeredi    2014-10-24  139  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


