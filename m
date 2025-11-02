Return-Path: <linux-fsdevel+bounces-66685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 221F6C28C72
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 10:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EF714E32BD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97879268688;
	Sun,  2 Nov 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alal8TbE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486E126561D
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Nov 2025 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762074644; cv=none; b=GmdJ8PG6/cpeNZrALYXfmYX7iQ8Rj37/ThsQBkzif/LBC2imcY/XRSP/9MEHGpRrT/jOxHdeyAVAjkUC7meEdt3xS8iYsa1Lm5ONBhIadK2IfNunglZEltjUyh+dYz2gm4P1VjZWRsXdbiXyFOB0BXEyIOG5GBgN0BEwij+vI5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762074644; c=relaxed/simple;
	bh=qD5/FoCTLkyARa5AQA/+l/GmKs4cQP/TjyJXRCDh7V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryns+WQbdMMInlIfIMZLrt2SNzBpICus7vZ71H6T8iOJMZE3QmcCu8SYg8/5gGuJ7hdN1gTl4dzztF1sEtRSXXSz1+mibXA+hLNlQe4bTbDsOuw5YNVmxpJw135CCTXv+xH56Zc2QMAn7McaGiSmMiwIdQ9DfDyZLRwN45AoeSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=alal8TbE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-474975af41dso26018185e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Nov 2025 01:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762074641; x=1762679441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7cGnlggGwCStKE++4amSGBWkBioEl4HVTFZyJlNXgM=;
        b=alal8TbEDa6UmErn2TtkzcOcEtPBPzGwabKg1CAlbPQbStnCMDo+2uiqYePLgYUaZb
         6LabLkSUoIiy4veU9N1s1YaKTfN+KbUNCJrrQkS8dgFHfwD2xTBEbF3kzD1I9l8SJWzf
         +eiFOHsRvalc0GiwMOYfl9cXPvlWswx15mqRqD+OKUr4eIjKZkXksgGCGxZDGky4KQvN
         CPUKAttVS/EEjYsg4yHcLFDJT6nPyGtfkE6Xh+tTSJYHIjoj0soooa2a5MkwAPEXoHhv
         aCpWJPsh/IzxZx/q4qszCfx8+dr9LgBToMDWYtPHXxYjKHO+PoxHS25SHI+tfycHF83+
         u7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762074641; x=1762679441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7cGnlggGwCStKE++4amSGBWkBioEl4HVTFZyJlNXgM=;
        b=BTPZ4DnRHCsmwgT5OIUlahFq035MXQRwb8GjoDcbFy3jPtKwdbMiAuUIgWlsFQxz6m
         8gMyLHPCDHkpCaL4gnO7JKTWuz0Rsi6oi17Qjc+IeXZMzYiTQs/qiRu7prjKFSWt7Ecm
         48P0t06IzBdi4ZhTXO+XGP7L9DSDMemI/uAgVF04qVlQ9hpzcHsRrBwHKBt8PtoDnaxe
         ypszbny5365fGXseYUCKE7oo44kz4xynUwMbxB2Zk+pcrLdSbDaGAZPL3qdv1xRxUUe2
         lKql6jn8y5CE1s7EXBWRNUK7JAu7I5No8NLebA5QlR5Hu3aqzpMrpfOjI21sK/UMak6o
         tHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+jgEb1akhHo+D9r0y6tUdqrF5c1iEBmFbzC7zuR+ywEVa+p4kIVuXJVEWrN0LtoO8quVukfGX62zTkqCc@vger.kernel.org
X-Gm-Message-State: AOJu0YyY5yjeCz4FaDuBNDxTl3/0W0g44yeUhu5QZE0iDLbveumnPWTK
	S1AH2WE1rnr7aDK5+EimRPNNyldo0FzJTE4hfmy8KGw0ZJQYOivPxFAPfGCxFmsnuEY=
X-Gm-Gg: ASbGncsSx8B/xuqccvvtuGbhNCVnFZpqNWX7ETCPNYVx+4fgq3GJZVr7r4wON0fj0gT
	zRO3ydk1UfSpCVkhp2jwU27SoqmUb/xhZOsneeJexh8tvXp9Zr9MY8Cmi0XZvYy9dmE3q3HrJJP
	DBfwIWD2yO/fKSmvpKG4OhoWpO2wp9NdQ8y1Wrp7SprIEpbbn6VrkUGFDBlxysSXQ3L59wQclYf
	HPISXhBPs09vTdS0nnAOJD+mkQniqJlWK0Fjb9hwhxlRJjy3uANsuLchlFlJaYGuOg+EN1h7yCN
	V7g20hTUbINs4scAu/+1+cVuWYvkvyxDB1z8DpJ9hdHlxMtt4uZann1XXF8ujnGVxbsCNU9tYa4
	F0ry7OuAw/mpe3UZFfAX3Da0ACC6z08SF3gr0BhLnfO9Pt+PQ1K06zYE2DHkdZ//ArIfyzBRkTt
	+XdUNesvH1qXxCsSuD
X-Google-Smtp-Source: AGHT+IECHyILSrbd0QXTTRGviLOb/cK2qhNsm2Df6/6M1eVjARvdq8vgt6DKUnfZZFhEiuN3prCXvw==
X-Received: by 2002:a05:600c:828c:b0:476:651d:27e6 with SMTP id 5b1f17b1804b1-477308a8967mr82981805e9.36.1762074640521;
        Sun, 02 Nov 2025 01:10:40 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c6ac1645sm8714761f8f.12.2025.11.02.01.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:10:40 -0800 (PST)
Date: Sun, 2 Nov 2025 12:10:36 +0300
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
Message-ID: <aQcgDOjZqJqkKNXa@stanley.mountain>
References: <20251029234353.1321957-5-neilb@ownmail.net>
 <202511021406.Tv3dcpn5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511021406.Tv3dcpn5-lkp@intel.com>

On Sun, Nov 02, 2025 at 12:08:47PM +0300, Dan Carpenter wrote:
> Hi NeilBrown,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/debugfs-rename-end_creating-to-debugfs_end_creating/20251030-075146
> base:   driver-core/driver-core-testing
> patch link:    https://lore.kernel.org/r/20251029234353.1321957-5-neilb%40ownmail.net
> patch subject: [PATCH v4 04/14] VFS/nfsd/cachefiles/ovl: add start_creating() and end_creating()
> config: x86_64-randconfig-161-20251101 (https://download.01.org/0day-ci/archive/20251102/202511021406.Tv3dcpn5-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202511021406.Tv3dcpn5-lkp@intel.com/
> 
> smatch warnings:
> fs/overlayfs/dir.c:130 ovl_whiteout() error: uninitialized symbol 'whiteout'.
> fs/overlayfs/dir.c:130 ovl_whiteout() warn: passing zero to 'PTR_ERR'
> 
> vim +/whiteout +130 fs/overlayfs/dir.c
> 
> c21c839b8448dd Chengguang Xu     2020-04-24   97  static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
> e9be9d5e76e348 Miklos Szeredi    2014-10-24   98  {
> e9be9d5e76e348 Miklos Szeredi    2014-10-24   99  	int err;
> 807b78b0fffc23 NeilBrown         2025-10-30  100  	struct dentry *whiteout, *link;
> c21c839b8448dd Chengguang Xu     2020-04-24  101  	struct dentry *workdir = ofs->workdir;
> e9be9d5e76e348 Miklos Szeredi    2014-10-24  102  	struct inode *wdir = workdir->d_inode;
> e9be9d5e76e348 Miklos Szeredi    2014-10-24  103  
> 8afa0a73671389 NeilBrown         2025-07-16  104  	guard(mutex)(&ofs->whiteout_lock);
> 8afa0a73671389 NeilBrown         2025-07-16  105  
> c21c839b8448dd Chengguang Xu     2020-04-24  106  	if (!ofs->whiteout) {
> 807b78b0fffc23 NeilBrown         2025-10-30  107  		whiteout = ovl_start_creating_temp(ofs, workdir);
> 8afa0a73671389 NeilBrown         2025-07-16  108  		if (IS_ERR(whiteout))
> 8afa0a73671389 NeilBrown         2025-07-16  109  			return whiteout;
> 
> white out is not an error pointer.
> 

I meant after this return statement...

regards,
dan carpenter


