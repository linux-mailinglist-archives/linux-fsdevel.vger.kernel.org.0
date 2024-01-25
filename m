Return-Path: <linux-fsdevel+bounces-9020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8128F83D094
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 00:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064581F21606
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 23:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A287134BE;
	Thu, 25 Jan 2024 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G/U+Uh7x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3412E4E;
	Thu, 25 Jan 2024 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224956; cv=none; b=QLfnUnU+qhjET+cZUDhpxFfZgUno1M0MVLgXdX2uONqZpAvb/4m02gHrnfIjrpX18wBLmvKu1dQ2Zhzd57lh7PdWMCA632z+8BzaVI+2/KcTSQB8F91Zmnu9qfyR+pt5A7LNl2vdEXdwi3/PW78H3err2u2rBC5qvVE5/xpcp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224956; c=relaxed/simple;
	bh=587/YeORTOjV4+4rZmCxNEau5T3CAeS60+mA4rS7qv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUkzn1AZdvHa40UHL7T2JgbqYAlJP29uob7mdEhl7J9gW6JF0h6cItAwHCIfOCjPy614j4TAKP4ODtazNykbmArrTglsWevz7cmTrZpQK9ANZA4yuM4a8wpGTsPQPk89VCwCsSy1L3K2bRumk+1dikg6F6VZi73NStqXP1mFOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G/U+Uh7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1471C433F1;
	Thu, 25 Jan 2024 23:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706224956;
	bh=587/YeORTOjV4+4rZmCxNEau5T3CAeS60+mA4rS7qv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/U+Uh7xSlHZmssoQ6TdqtZIO6/P8sce/TuhJLXQfa15z5QJa4CejQ4Y+tqrGECzP
	 p3mCGeahqF71sPfCIBBDlc5fWrvczb5IQ5wMqJub3eHrM/aJKUZeQ18I+a1VySgRz8
	 OZGYj+umd8CQIOdCRaL1CSHJDCDePSXzzg8b4aNM=
Date: Thu, 25 Jan 2024 15:22:34 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org,
	willemdebruijn.kernel@gmail.com, weiwan@google.com,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Thomas Huth <thuth@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/3] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <2024012558-coasting-unlatch-9315@gregkh>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <20240125225704.12781-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125225704.12781-4-jdamato@fastly.com>

On Thu, Jan 25, 2024 at 10:56:59PM +0000, Joe Damato wrote:
> Add an ioctl for getting and setting epoll_params. User programs can use
> this ioctl to get and set the busy poll usec time or packet budget
> params for a specific epoll context.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |  1 +
>  fs/eventpoll.c                                | 64 +++++++++++++++++++
>  include/uapi/linux/eventpoll.h                | 12 ++++
>  3 files changed, 77 insertions(+)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 457e16f06e04..b33918232f78 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -309,6 +309,7 @@ Code  Seq#    Include File                                           Comments
>  0x89  0B-DF  linux/sockios.h
>  0x89  E0-EF  linux/sockios.h                                         SIOCPROTOPRIVATE range
>  0x89  F0-FF  linux/sockios.h                                         SIOCDEVPRIVATE range
> +0x8A  00-1F  linux/eventpoll.h
>  0x8B  all    linux/wireless.h
>  0x8C  00-3F                                                          WiNRADiO driver
>                                                                       <http://www.winradio.com.au/>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 40bd97477b91..73ae886efb8a 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -6,6 +6,8 @@
>   *  Davide Libenzi <davidel@xmailserver.org>
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/sched/signal.h>
> @@ -37,6 +39,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/compat.h>
>  #include <linux/rculist.h>
> +#include <linux/capability.h>
>  #include <net/busy_poll.h>
>  
>  /*
> @@ -495,6 +498,39 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
>  	ep->napi_id = napi_id;
>  }
>  
> +static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
> +				  unsigned long arg)
> +{
> +	struct eventpoll *ep;
> +	struct epoll_params epoll_params;
> +	void __user *uarg = (void __user *) arg;
> +
> +	ep = file->private_data;
> +
> +	switch (cmd) {
> +	case EPIOCSPARAMS:
> +		if (copy_from_user(&epoll_params, uarg, sizeof(epoll_params)))
> +			return -EFAULT;
> +
> +		if (epoll_params.busy_poll_budget > NAPI_POLL_WEIGHT &&
> +		    !capable(CAP_NET_ADMIN))
> +			return -EPERM;
> +
> +		ep->busy_poll_usecs = epoll_params.busy_poll_usecs;
> +		ep->busy_poll_budget = epoll_params.busy_poll_budget;
> +		return 0;
> +	case EPIOCGPARAMS:
> +		memset(&epoll_params, 0, sizeof(epoll_params));
> +		epoll_params.busy_poll_usecs = ep->busy_poll_usecs;
> +		epoll_params.busy_poll_budget = ep->busy_poll_budget;
> +		if (copy_to_user(uarg, &epoll_params, sizeof(epoll_params)))
> +			return -EFAULT;
> +		return 0;
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> +
>  #else
>  
>  static inline bool ep_busy_loop(struct eventpoll *ep, int nonblock)
> @@ -510,6 +546,12 @@ static inline bool ep_busy_loop_on(struct eventpoll *ep)
>  {
>  	return false;
>  }
> +
> +static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
> +				  unsigned long arg)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_NET_RX_BUSY_POLL */
>  
>  /*
> @@ -869,6 +911,26 @@ static void ep_clear_and_put(struct eventpoll *ep)
>  		ep_free(ep);
>  }
>  
> +static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	int ret;
> +
> +	if (!is_file_epoll(file))
> +		return -EINVAL;
> +
> +	switch (cmd) {
> +	case EPIOCSPARAMS:
> +	case EPIOCGPARAMS:
> +		ret = ep_eventpoll_bp_ioctl(file, cmd, arg);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static int ep_eventpoll_release(struct inode *inode, struct file *file)
>  {
>  	struct eventpoll *ep = file->private_data;
> @@ -975,6 +1037,8 @@ static const struct file_operations eventpoll_fops = {
>  	.release	= ep_eventpoll_release,
>  	.poll		= ep_eventpoll_poll,
>  	.llseek		= noop_llseek,
> +	.unlocked_ioctl	= ep_eventpoll_ioctl,
> +	.compat_ioctl   = compat_ptr_ioctl,
>  };
>  
>  /*
> diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> index cfbcc4cc49ac..8eb0fdbce995 100644
> --- a/include/uapi/linux/eventpoll.h
> +++ b/include/uapi/linux/eventpoll.h
> @@ -85,4 +85,16 @@ struct epoll_event {
>  	__u64 data;
>  } EPOLL_PACKED;
>  
> +struct epoll_params {
> +	u64 busy_poll_usecs;
> +	u16 busy_poll_budget;
> +
> +	/* for future fields */
> +	u8 data[118];

You forgot to validate that "data" is set to 0, which means that this
would be useless.  Why have this at all?

thanks,

greg k-h

