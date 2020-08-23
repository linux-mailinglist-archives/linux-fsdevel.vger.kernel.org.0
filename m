Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EBE24ECA6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Aug 2020 11:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHWJzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Aug 2020 05:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgHWJzD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Aug 2020 05:55:03 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D42712074D;
        Sun, 23 Aug 2020 09:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598176503;
        bh=HrvLADze6jQwdCOAHEEkNsKKmZYP3TCIKI2jMHtJnZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cw+13OfTmZurCxaRaH4x6TJu3dnR+1HHxil4y35KARXVlONywdfSQi2TOdzg1f2VA
         DBJUKi3mtQkmV6P9rlQAjjNwy+d8j9jPFkYATmOo/EpU68Zhpr8Z7cGgutO3EoASpE
         oFspIdbLiHxkWjKuYJYpY8tOP4n/G1Gh3RjYxrIc=
Received: by pali.im (Postfix)
        id 01906EA3; Sun, 23 Aug 2020 11:55:00 +0200 (CEST)
Date:   Sun, 23 Aug 2020 11:55:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 02/10] fs/ntfs3: Add initialization of super block
Message-ID: <20200823095500.ug5vibiv3hy3luqs@pali>
References: <caddbe41eaef4622aab8bac24934eed1@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caddbe41eaef4622aab8bac24934eed1@paragon-software.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 21 August 2020 16:25:03 Konstantin Komarov wrote:
> +		case Opt_nls:
> +			match_strlcpy(nls_name, &args[0], sizeof(nls_name));
> +			break;
> +
> +		/* unknown option */
> +		default:
> +			if (!silent)
> +				ntfs_error(
> +					sb,
> +					"Unrecognized mount option \"%s\" or missing value",
> +					p);
> +			//return -EINVAL;
> +		}
> +	}
> +
> +out:
> +	if (nls_name[0]) {
> +		sbi->nls = load_nls(nls_name);
> +		if (!sbi->nls) {
> +			/* critical ?*/
> +			ntfs_error(sb, "failed to load \"%s\"\n", nls_name);
> +			//return -EINVAL;

Well, I think it is a fatal error if user supplied NLS encoding cannot
be loaded. If user via mount parameter specify that wants encoding XYZ
and kernel loads different (e.g. default one) then userspace would be
confused as it would expect encoding XYZ.

> +		}
> +	}
> +
> +	if (!sbi->nls) {
> +		sbi->nls = load_nls_default();
> +		if (!sbi->nls) {
> +			/* critical */
> +			ntfs_error(sb, "failed to load default nls");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
