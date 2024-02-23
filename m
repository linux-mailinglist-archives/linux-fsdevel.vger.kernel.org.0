Return-Path: <linux-fsdevel+bounces-12544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A07B860BE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C379C1C20B2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 08:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837861799D;
	Fri, 23 Feb 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+4azPBF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0885171A6;
	Fri, 23 Feb 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675853; cv=none; b=TxhyIyl8jlBcjA/ezdj5KbkENTy0+E9GhBi8lpln9SmXvRI58dp9YTOeTcv4oukDDq0ceE+Z0DQPRiIx31asq8vBrIGXIZ90C4W7RegLUTNNxyzTH4YxaIkdXb2ifPzEFyPOzh+hBtz0a1l4PDZ4I0SJO3OJrwQL4/F98GM2F3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675853; c=relaxed/simple;
	bh=G58eG4LAAef5vMNI29H63UmRbuDbS1Aa5HYHb5xMBms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIwwtCMLU8N8L35sMkKQYIkbrDFzEEDm87tXdf6y7NHOzs74zCM0Z3hAKRxdO+VURFN9D0Ei29cVbIZeVYxmwyQ+RTvm5ehY4DeIX+fu6Zgfz8zKOMWzUIXD7A1LS4bDvV+g6eM3EMG2HnCbsN7GkKuq2z+aR7kyO/i5H5fqH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+4azPBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08253C433C7;
	Fri, 23 Feb 2024 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708675853;
	bh=G58eG4LAAef5vMNI29H63UmRbuDbS1Aa5HYHb5xMBms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f+4azPBFpDsYrpCsm+Z4FHfyVeKBwkCE2CMDekQluaV859vQvV9yJ3gJ17zYyP50W
	 d6cC6/GvZ98hx+Te/n55UOwPIYML+e9UIOn9DYyS6tNYi9bI1Bjf9MZMHHzT1M6Rl1
	 Q7TSQK2crhB7CD38zOhaBjbTrXdHkJ/yYS4qdHD8dIMHxG1RE5Ul0CvO5WdLvbdq2n
	 lr9QjLyNPcfzUz/gEQeM04XwmKMaQG0qIkZPN0SK+F1Wd8dW0poWMRnOD44bMjaTOU
	 fKokSCYrZ2KNND2zcTij0/pwg2LGRxREgIQhmsH6ATqfvxKqOombIpycmPjN+cvWGR
	 t2ETJKasCwXaA==
Date: Fri, 23 Feb 2024 09:10:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 10/25] xattr: use is_fscaps_xattr()
Message-ID: <20240223-pfand-absaugen-44b5534dfcf9@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-10-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-10-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:41PM -0600, Seth Forshee (DigitalOcean) wrote:
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>

