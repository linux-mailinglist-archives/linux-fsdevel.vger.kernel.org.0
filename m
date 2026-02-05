Return-Path: <linux-fsdevel+bounces-76382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KMuMAFnhGkh2wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 10:46:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E16CF1010
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 10:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A85DD301BCDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 09:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41E339E6CA;
	Thu,  5 Feb 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7wZYF6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6052FFF8D
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284753; cv=pass; b=VljXfOqkcBXsFwKctqauW3wJmIA25arpnjcW3dn0BozDaO469SXPmsuvAeFbxtsslX4l9zX8LAlmC8YtovGGGOxQAs/miUUCkC2Cpy0pMRwYRtNdBAYUobQNFieg3EHzsB/0bwtLRUkXq3aDRMV2cofxNTnJ5JIjwMR+9vhQfnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284753; c=relaxed/simple;
	bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFsENoh4XI4q5jBQB3HDvxKMotvDVBnRiGnS1zUobp1DuSCw0VvclCKrtNQfvKhPqum2EBHzL61M40Tcz3spUbMPAlgLnmQmrB3RFlrWyRW+vggM7oiuz2w9BRARRDxaotMcHAizqeb0Ib1D5O8YcpWJOSJx0yCHIzT/bdkidu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7wZYF6o; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so136731266b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 01:45:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770284751; cv=none;
        d=google.com; s=arc-20240605;
        b=gi8Nq6autNZTgnjiPvBVGilT7cpPAe9khduCCjsvgoy9C7Rkx1gXd9wpcVGBQDTko6
         UjFyqC3SO9Ys52b7gRNfdzV7ktlZnFEbClDzPGA1du63/RQ9rvLuGLdZv7we+66f87cY
         23KviAIPjl5MW1pV+v8819BIEp3uZy44sA5n8Ih0xR5jMkCp7GxoveE18R6ZnvajHy8D
         aDIRQUTRdpIcuEbKW8+6txzLo2KnuIua7Gr8RoJCyd0PS1Sie7LTdKIGWc66PiUgDAim
         ERjxWbwX78CqoDWesZifaSWemBdH7j3ef1nr/vSyuTlA6ClHlKimvW/T59rBGa54K8xZ
         b8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        fh=F5dSsb8sDxp71nHWVMubUAU23eEnkBiU5iV6INFjsfk=;
        b=Jsyr2KbaXMw2QJt49b31aY0u5CAiVvNwVJU9/aRTY5hMn4tQl8aPR7mP1YAVw58ddx
         JWo80JB/EZbZBl4Bm5oJt+0kH2ueOvjKVdGu3m6HcTWlOaIDzHKYGsx4MupnR0w5b8nJ
         BA//s7awq00UvZG0rAKwa2Ed/05Uc8QsYAPVpFi6+M5sHNZv8TgDl8zleJzAkhskSi1l
         K4gughnusPcuzW6py0RgVrF4weFXngcixruIF47O8p/Zis2u6KY9GvW/5FhfTyqCv7l8
         aUG7JCRu5ZS8xrvnDrqj/gX+J5PiKwRk4WWHJ2FZB1rWJsF6CiQ1NK1hs8Hxa4FDXI+S
         upIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770284751; x=1770889551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        b=X7wZYF6oGkxVE+gLTBtcX28o4eYBAX3e3P5/p1DkotCtFvnSm+dNdGmggiKQnap9HF
         uJoR8Y/7jQwtGKgtwXZNQtMOcaDouskzI9DbFRdinBwM2G8kpSDc+wVOPd9ayKvPaZtX
         qDZsWavmVfL8txVAZaxKDRyNO2gl3nDKYj6Y08WRzZFoXlLH4OBDdd4dCHPmAv9LaYhV
         aYyqyMoVjKFMXFsylm9qYTAL0LLdTNasCpSpfzLfkc3XzkPNORx9OBQJnvhWeWVvJgyV
         IFPElSh1GAM0WngNDgAYeJbIEwtbP3kxmdE1hnqP1mOoFVug/wkO0WrOFsaHCyIytL65
         aJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284751; x=1770889551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        b=chQy2U/2gXzZRR7vB3ncRQCnJ4Im6pSsM/h8IRfZKPWSm3kk2T2pdF10XiZWz9sER5
         rAVn8Zk0x+8K/oo/UnCCxrx/Id/Nzr9h7PY+thhpqd0k3UOHTOakI4wqvKYZkfKjZLCq
         a2Kaq1dqPJpLFpgLuBPwHd+a8IwtPF6dCv2D9CQaeJwjkdaWLcvkxq5i9NNh6/cYgBer
         JM6+ISeLqxpbH71+0NzeEsSSjVSggEJf9JIPDdXFL59o9lPkMp05B82PCO5oLOy1omHo
         7EzlYzmPRo5p5blUov6X4sVCm6Cm+Myw7I202+kN1sZEce/C+n8R3c6S6+DSnXXSFImv
         aMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcyZxqJzXdBys2zuDNvMtuiV52BJvnoFEGiTzB0knbDMcJtMY7iPgXaUADvJAY/VcWRIHGcEUl/3P+8Lm6@vger.kernel.org
X-Gm-Message-State: AOJu0YwEYcr815Doas/rQZjsHerOxLgzyewaxQEQ4JfQGObe2K7VRp2q
	ctAXDALV5sAQbHZCd08PcgLqbszHaP4v7Rb3UFm4WWlDqNlmd3QGvDUtrqmWR+T7TTZ3uqFiSpU
	dnzMScW8ecdki/vG39pBBQ6VTQWcWK+U=
X-Gm-Gg: AZuq6aKLCiAZCJV3B4nAdiC4KD+OObhtnIAKAjpAkcYBDNn48EUEkJw3EFNhOJ9Ewg3
	5riWCGXapofEb+8HSqk91s4NP7TIPQfQmFd9v6DK96AeQM85lvukga1cDzxX9QUa7ZqUhvoIVNK
	8x3F0d1guF4sdZk80hyQtmhwuAawK+BRtR0O9G+147QKf+UTM7mkDw61rbI4kQRdd26lnecK+Co
	Tz33Hqd5i7Y/mLVoxsHKBCzJTNLkYQb4jsSrNu4uBdjdDjyg3tLxdsJhBBxeqRZ6UwraNGeixYJ
	ZLyyOysi+a6AMOt3dJwQ8i9t6EWE6Q==
X-Received: by 2002:a17:907:7f92:b0:b87:31d1:4131 with SMTP id
 a640c23a62f3a-b8e9f64603cmr435430866b.60.1770284751163; Thu, 05 Feb 2026
 01:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-13-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-13-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 10:45:38 +0100
X-Gm-Features: AZwV_Qg7CM-kXxjB2Qin-euJkaOUd7ni190R_n_ZLhun34eHr5T-i9uF6CbqXdo
Message-ID: <CAOQ4uxi3bNYq1b4=qL-JLi19hRwurntfLZXhUMVL003NarBdGg@mail.gmail.com>
Subject: Re: [PATCH 12/13] ovl: remove ovl_lock_rename_workdir()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76382-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:email]
X-Rspamd-Queue-Id: 3E16CF1010
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> This function is unused.
>

I am confused.
What was this "fix" fixing an unused function:

e9c70084a64e5 ovl: fail ovl_lock_rename_workdir() if either target is unhas=
hed

What am I missing?

Otherwise, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

