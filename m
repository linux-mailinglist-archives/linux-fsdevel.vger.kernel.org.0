Return-Path: <linux-fsdevel+bounces-29808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA57B97E288
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 18:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740421F2149B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Sep 2024 16:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE102B9DD;
	Sun, 22 Sep 2024 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UwRDJcqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801FE56E
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Sep 2024 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727023848; cv=none; b=Y3cX7j623/I1xQ2oL55dMW8zWWdLJKPuBFr9xKJUOk7ocnnYuWN9KfMENAt81apIhURNsrHeMp7owsI++saO3JN+nJjExOA1xPWHlfZZZuyt2DblG+xLH8FlonaBx0xuDzwoRY8MZzP3ueneG8v1TPw66IqY+RsgKskjfRVHiLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727023848; c=relaxed/simple;
	bh=Tyr9i8ipkgWmeb2qVyjavDvEUVtyEtTlYitSUClBqwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEn0JkjKKRt44DhMo7RFg2uqoC/zTZeJEruMTMSPLMRHcOsXDSA+n7DbubXz6sqwKC/SQbyGmf2K8S9EcxfbBKPJTOsA3jiRJ5QyMSBCFAS+kJa03aDYWBqFtukjS1N/VlmhbZsoE5GaivdavgeXLUqi/6/vt5/j6jdSRPGvgvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UwRDJcqj; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727023839; bh=RkemQxSTekqBWW7gSaSVQi9ocEzIYYZgCqHh75M1TmU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UwRDJcqjY3dTothR/Wd5VnZeSRGRavmeuAKHhdpuB1JLyfXIyO66qpIUgqHV6EeHAMOUc8ZQAVgXw0YHgrm/85TcpXVcDplH+xk+wlTVML4GA7NOG3jH+qe+VGX2hqiX9rflPFyLoloWt3nnsfTBMz9sBaRtg8sa0bFotn7WWTYCBsbPaWMlTbc4QUr0HZVgxKasm2cGgHeplU1DTRZlwKp/Ch2SIIn1Ag51ruKQPnZBy/hrTSD13djIQEHX+pgQPLJE6KkY6Xc06siFx3Bhu19ujoJAY0yDaRtEIiqK811ddYrcytqnrsWeKscdCUubxXQfS5fZlbIle50FodUt2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727023839; bh=i+/Kmoz7yPrAzKAWS6N+sz+eQCTb2zbtDQvoiOT9K9N=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=KSGv+SBQthd35oevC5B018TD5aaqekurHoAH9FrBLJERX0YcEG1CTiIwsPefMsnB2nxKtFG3vt87k8/Efccb2JAtF5PTzxRtC6uM8iKElObBefx6PDaHru0NroOhkI5kxNInT1PoE/5JgCJrJkCK7JbMKOqznlnt+/ARRg+YhCquxQMpxglGdobvwil1rm87R5KYSbnvpJbajAOKoVnJWT6NVGq/YnGUkEXZ9751E9jCZ3CfsdvhCpgp0vOEv2Unb/nuU+JQxpNB6IK1fix0hISSH0S65sG/IQWL/WraDumgZmELfd/Z6QNRGTi4aWk9Kycyih9/cecFviRzpixF7g==
X-YMail-OSG: rSeCZIsVM1nwHEwIqfLJtUZ5_uREOgskC9k2_NL7g_qFbdiC7W4iDl3VElv6XC3
 G40_IzyiDgA._EBfqZqM5kSyCj_cRK8W4WrrT0vIazHr90T.w78ozUIilwv8.QAMAC7AEw_mPNnr
 WwPfCj48O3eKfZ5O4ZJ1N3l23pcAhzTAXVfnzpijo6Z_V.YZKODQCpoMWS2iefW7tIvroefmKbXQ
 JI.l1vgttQX38vVUfCgHeSzKW_3xDUcIPSrtV0rsM8ix9b9iiEzvh0iZ3ZyeNlfosnLqcjfs3GzR
 GVUr12bWh_Dh7QwQTOiQyMyJdgdRGgiMVYEu0Vg3kyiPZxqSbMrR00wNmDgmJPtpnaj8uE9nsBAk
 Izsv2HHdYs3TPvGGmJc92YhuSrCOWyGMqCFoyEeGFHoJLYeFuRb16aHh3JoyhPxweNn0tzUkJCzA
 Tg5L7De3iiIXAfVaR6VGV4q5hie6VGPVsmeyEAI.u18YfDPAX2EEKYGno8MoV7DrTec6TttDB8LO
 OnhXljQEaPvVpBtXd0Krv0ezKZf__tYoggKYbiS7o0WXSgTbQLyJLVwxrfjvncVUpGPKxZblG1hx
 hNZZJrGr7GG9TrRlz4ilWBieBaKbkhY.Emlx4GszhHO3KbEEZoFjPEM5MhVs4q_5rEbadWk8O3js
 At.0AlCVXBm6xhPv5TKtUuLG.iN4uBWKz4PRX3uRoaJdN3O41Ul9JanvMKFfF2gRK_e1U0sNeMxr
 bXyxfcpRKBsu3aLCQiwwfspJNVHekQReEU7YMZ74phA.5Nhm4t1BgMVrt2kyZVRCMsw4lrAlSZZ6
 zsBt32nk6oJ0043G9EGc0QPsUkYNfcHHkbhGKuAWPizLLUStEFlhjjOxeYGOH.NINMzu9FkxLOj9
 H1gdymCL7z6wfLRIef.GcvBDd92KPqiMz0XfUndbPHV9lp28B4aklvgFB_.n.g4dVjxy6eDjzgBt
 Jr5M_C2_NTTbHYjcePriKJvJlGSnJebHUtyIlERMA2M4mIP0iEtBV34yUkd.Nu2niNwpD60GLV4f
 Q8eF2q3FW8yCvhM62KU0wwTWUllOr9tyActdADKIRsNH6EtODd5X2RdvikP.Crmg6mL8xisYR1Lw
 foeoG6gVcOYfwjtFEOmfs9XMQ1SJuAMZxMvmP8k.IxH1ciHqsPWclKPhoRE.y.yXjM_yx3Yjp9L7
 TL4EJt0ViaLh.ElnpA7Ezc7ApR4Yy18ptVzX7q1J0i9308LS_Xqnr.2oBFY0ORKxBrT.gpNEEVs6
 vvbJXUPp8l6TLOcGDSJ0dJKe.c0RlTvK5ybHP0qplPvWkHI1u9IkQmaxUes7lVO7gAiwwoxNZsA6
 61Qvb.CYZAYFo1UYnoQAym9Z6bS3r44oyLs7wXV_0SW6v6i2E71XxrYv7Hn42nA5ax.TwOHqZIq6
 AtCCNffI5UkmSePtBdTUvnM3_xe2ytx024PsLK8pZqd8FEoh5NDvqUbmwXoKIUm0wvFelDygm51M
 M7WTfFRCa2ImcEh2grV0n3vSowfiES1smV_jsXq7j.wgb_dE5FddQrHGRO76Hf4u9FFHiR9IcA7u
 PRnV6CI46pphH2Zy2lB3dfEHSJp2.YQFNK30vFfk1kiKr6m28p_YJ9IXnSNnGODc4W_OpjYtmvso
 2zgeOIziHSvxZCrX8Gpi.nlOxNyBtnTe5X.KC3ti8QIFe58ysxVXJwcYAulUpfpda7iA.CvudNE0
 TKhzAKW5MOx1gvAqKb_TioJWDBmN5TR7ApCE7.EA_etvwQCZ9UwBKJDg1wam_kxwoOsIwGOlLFBb
 MqAVSib_hRUKCRQHy7PQY80qabP7TEEEkCdVeBAssJPGjsNqf4oIlQ0.2ga_7M85kGnfse1INVBo
 qRcxuSwOVBLXSCH2OJF.nfkDyFQftL1Q1F.vk6laUYGEBvgF0QX.xCkGW37QEgGHWCfxcq2gmohj
 H30_RCe8H9CNfEoLkRNjXU86YuMzEwruxzap_vRZ7Lk8TF8OOuzsOanwjBapKAptgixe8BkVEmuf
 1ECgL3nQm4NYrMQZHH8Q4w8yJSvfs.e_IkCHGW6_kbl4Vk6BRw6r8_3YcHfthzAmOK25.AYWkgUx
 nrVURNWK3HzYI3c9HzPJtRhL1Xl3wf9yxRxn2VXYsUC0hi_BdbxyHUjJ1SV9FqxiTDk.teQZBkKM
 fGvUl5ObqFUaGyOJLDizr5yZRwoOpC6B.ZV.OWc9sQqHW54u_UJMn4jXk2gjBi8PTIJgXdsQTA_d
 yUwGvP5oQc1fuXHwdB2jq6gfYybWUeFfDNDnLkk8J.tBbOsngRuIXkxZfbS9xIP.qVmKRXKZo1WY
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6048f999-efd8-471c-b66a-c3dd3b4a8a1e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Sun, 22 Sep 2024 16:50:39 +0000
Received: by hermes--production-gq1-5d95dc458-4tw7n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3aff9c2f61c09c580cdd04eaf820b205;
          Sun, 22 Sep 2024 16:50:33 +0000 (UTC)
Message-ID: <afe99ad2-bb53-4e80-bc43-f48b03b014cf@schaufler-ca.com>
Date: Sun, 22 Sep 2024 09:50:30 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/8] rust: security: add abstraction for secctx
To: Alice Ryhl <aliceryhl@google.com>
Cc: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Miguel Ojeda <ojeda@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
 <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Daniel Xu <dxu@dxuuu.xyz>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-5-88484f7a3dcf@google.com>
 <202409151325.09E4F3C2F@keescook>
 <CAH5fLghA0tLTwCDBRrm+GAEWhhY7Y8qLtpj0wwcvTK_ZRZVgBw@mail.gmail.com>
 <39306b5d-82a5-48df-bfd3-5cc2ae52bedb@schaufler-ca.com>
 <CAH5fLgjWkK0gXsGcT3gLEhYZvgnW9FPuV1eOZKRagEVvL5cGpw@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAH5fLgjWkK0gXsGcT3gLEhYZvgnW9FPuV1eOZKRagEVvL5cGpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/22/2024 8:08 AM, Alice Ryhl wrote:
> On Mon, Sep 16, 2024 at 5:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 9/15/2024 2:07 PM, Alice Ryhl wrote:
>>> On Sun, Sep 15, 2024 at 10:58 PM Kees Cook <kees@kernel.org> wrote:
>>>> On Sun, Sep 15, 2024 at 02:31:31PM +0000, Alice Ryhl wrote:
>>>>> Add an abstraction for viewing the string representation of a security
>>>>> context.
>>>> Hm, this may collide with "LSM: Move away from secids" is going to happen.
>>>> https://lore.kernel.org/all/20240830003411.16818-1-casey@schaufler-ca.com/
>>>>
>>>> This series is not yet landed, but in the future, the API changes should
>>>> be something like this, though the "lsmblob" name is likely to change to
>>>> "lsmprop"?
>>>> security_cred_getsecid()   -> security_cred_getlsmblob()
>>>> security_secid_to_secctx() -> security_lsmblob_to_secctx()
>> The referenced patch set does not change security_cred_getsecid()
>> nor remove security_secid_to_secctx(). There remain networking interfaces
>> that are unlikely to ever be allowed to move away from secids. It will
>> be necessary to either retain some of the secid interfaces or introduce
>> scaffolding around the lsm_prop structure.
>>
>> Binder is currently only supported in SELinux, so this isn't a real issue
>> today. The BPF LSM could conceivably support binder, but only in cases where
>> SELinux isn't enabled. Should there be additional LSMs that support binder
>> the hooks would have to be changed to use lsm_prop interfaces, but I have
>> not included that *yet*.
>>
>>> Thanks for the heads up. I'll make sure to look into how this
>>> interacts with those changes.
>> There will be a follow on patch set as well that replaces the LSMs use
>> of string/length pairs with a structure. This becomes necessary in cases
>> where more than one active LSM uses secids and security contexts. This
>> will affect binder.
> When are these things expected to land?

I would like them to land in 6.14, but history would lead me to think
it will be later than that. A lot will depend on how well the large set
of LSM changes that went into 6.12 are received.

>  If this patch series gets
> merged in the same kernel cycle as those changes, it'll probably need
> special handling.

Yes, this is the fundamental downside of the tree merge development model.

> Alice

